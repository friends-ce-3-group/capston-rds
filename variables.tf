variable "resource_grp_name" {
  type = string
}

variable "proj_name" {
  type = string
}

variable "region" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_allocated_storage" {
  type = number
}

variable "db_instance_class" {
  type = string
}

variable "db_storage_type" {
  type = string
}

variable "db_engine" {
  type = string
}

variable "db_engine_version" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_pw" {
  type = string
}

variable "db_backup_window" {
  type = string
}

variable "db_maintenance_window" {
  type = string
}

variable "db_backup_retention_period" {
  type = number
}

variable "db_monitoring_interval" {
  type = number
}

variable "ecs_sg_id" {
  type = string
}

variable "publicly_accessible" {
  type = bool
}

variable "db_restore_from_latest_snapshot" {
  type        = bool
  default     = false # specifying default makes this an optional variable
  description = "Whether to restore RDS from the latest snapshot"
}

variable "kms_key_arn" {
  type        = string
  description = "KMS key arn"
  default     = null # specifying default makes this an optional variable
}

variable "with_read_replica" {
  type = bool
  description = "Set to true to turn on read replica"
  default = false
}

variable "snapshot_name" {
  type = string
  default = null
}
