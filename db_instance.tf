resource "aws_db_instance" "mydb" {
  allocated_storage    = 5 # 5 GB
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7" # use the tried and tested mysql:5.7
  instance_class       = "db.t3.medium"
  db_name              = var.dbname
  username             = "admin"
  password             = "password"
  parameter_group_name = aws_db_parameter_group.mysql_pg.name


  vpc_security_group_ids = [data.aws_security_group.vpc_secgrp.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name

  backup_retention_period = 7                     # number of days to retain automated backups
  backup_window           = "19:00-20:00"         # UTC time. 3am-4am SGT
  maintenance_window      = "mon:20:00-mon:21:00" # Preferred UTC maintenance window

  skip_final_snapshot       = false # backups are created in the form of snapshots
  final_snapshot_identifier = "${var.proj_name}-db-snap"

  monitoring_interval          = 60 # monitoring interval in seconds (must be >= 60s)
  monitoring_role_arn          = aws_iam_role.rds_monitoring_role.arn
  performance_insights_enabled = true # enable performance insights

}