data "aws_db_snapshot" "db_snapshot" {
  db_snapshot_identifier = "friendscapstonerdsbackup27nov"
  db_instance_identifier = var.db_name
}

resource "aws_db_instance" "rdsdb" {
  identifier          = var.db_name
  allocated_storage   = var.db_allocated_storage # 5 GB
  storage_type        = var.db_storage_type
  engine              = var.db_engine
  engine_version      = var.db_engine_version # use the tried and tested mysql:5.7
  instance_class      = var.db_instance_class
  db_name             = var.db_name
  username            = var.db_username
  password            = var.db_pw
  publicly_accessible = var.publicly_accessible
  snapshot_identifier = var.db_restore_from_latest_snapshot ? data.aws_db_snapshot.db_snapshot.id : null

  parameter_group_name = aws_db_parameter_group.mysql_pg.name

  # vpc_security_group_ids = [data.aws_security_group.vpc_secgrp.id]
  vpc_security_group_ids = [aws_security_group.rds_secgrp.id]
  db_subnet_group_name   = var.publicly_accessible ? aws_db_subnet_group.db_subnet_group_pub.name : aws_db_subnet_group.db_subnet_group_pvt.name

  backup_retention_period = var.db_backup_retention_period # number of days to retain automated backups
  backup_window           = var.db_backup_window           # UTC time. 3am-4am SGT
  maintenance_window      = var.db_maintenance_window      # Preferred UTC maintenance window

  skip_final_snapshot = true # backups are created in the form of snapshots
  # final_snapshot_identifier = "${var.resource_grp_name}-db-snapshot"
  final_snapshot_identifier = null

  monitoring_interval          = var.db_monitoring_interval # monitoring interval in seconds (must be >= 60s)
  monitoring_role_arn          = aws_iam_role.rds_monitoring_role.arn
  performance_insights_enabled = true # enable performance insights

  storage_encrypted = true                                                                              # Enable storage encryption
  kms_key_id        = var.kms_key_arn == null ? element(aws_kms_key.kms_key.*.arn, 0) : var.kms_key_arn # Specify the KMS key ID for encryption

  multi_az = true # Enable Multi-AZ deployment for high availability

  apply_immediately = true

  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  tags = {
    name      = var.db_name
    proj_name = "friends-capstone"
  }

  depends_on = [aws_kms_key.kms_key]
}

locals {
  cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
}

resource "aws_cloudwatch_log_group" "log_data" {
  for_each = toset(local.cloudwatch_logs_exports)

  name              = "/aws/rds/instance/${aws_db_instance.rdsdb.identifier}/${each.value}"
  retention_in_days = 0
}

resource "aws_db_instance" "replica" {
  # count = var.publicly_accessible ? 0 : 1

  identifier = "${var.db_name}-replica"

  replicate_source_db = aws_db_instance.rdsdb.identifier
  instance_class      = var.db_instance_class

  parameter_group_name = aws_db_parameter_group.mysql_pg.name

  # vpc_security_group_ids = [data.aws_security_group.vpc_secgrp.id]
  vpc_security_group_ids = [aws_security_group.rds_secgrp.id]

  backup_retention_period = var.db_backup_retention_period
  backup_window           = var.db_backup_window
  maintenance_window      = var.db_maintenance_window

  skip_final_snapshot = true
  # final_snapshot_identifier = "${var.resource_grp_name}-db-replica-snapshot"
  final_snapshot_identifier = null

  monitoring_interval          = var.db_monitoring_interval
  monitoring_role_arn          = aws_iam_role.rds_monitoring_role.arn
  performance_insights_enabled = true

  storage_encrypted = true
  # kms_key_id        = aws_kms_key.kms_key.arn

  multi_az = true

  tags = {
    name      = "${var.db_name}-replica"
    proj_name = "friends-capstone"
  }
}