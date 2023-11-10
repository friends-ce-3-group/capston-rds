module "rds" {
  source = "../"

  region = var.region

  resource_grp_name = var.resource_grp_name

  proj_name = var.proj_name

  publicly_accessible = var.publicly_accessible

  db_name = var.db_name

  db_allocated_storage = var.db_allocated_storage

  db_instance_class = var.db_instance_class

  db_storage_type = var.db_storage_type

  db_engine = var.db_engine

  db_engine_version = var.db_engine_version # use the tried and tested mysql:5.7

  db_username = var.db_username

  db_password = var.db_password

  db_backup_window = var.db_backup_window

  db_maintenance_window = var.db_maintenance_window

  db_backup_retention_period = var.db_backup_retention_period

  db_monitoring_interval = var.db_monitoring_interval # seconds, min 60s

  db_sg_allows_ingress_from_these_sg = local.vpc_sg_ids
}