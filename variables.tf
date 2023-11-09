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

variable "db_password" {
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

variable "db_sg_allows_ingress_from_these_sg" {
  type = list(string)
}