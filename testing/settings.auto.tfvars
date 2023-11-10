region = "us-west-2"

resource_grp_name = "friends-capstone-rds"

proj_name = "friends-capstone"

db_name = "friendscapstonerds"

publicly_accessible = true

db_allocated_storage = 20

db_instance_class = "db.t3.medium"

db_storage_type = "gp2"

db_engine = "mysql"

db_engine_version = "5.7" # use the tried and tested mysql:5.7

db_backup_window = "19:00-20:00"

db_maintenance_window = "mon:20:00-mon:21:00"

db_backup_retention_period = 7

db_monitoring_interval = 60 # seconds, min 60s