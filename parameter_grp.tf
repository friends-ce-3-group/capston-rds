resource "aws_db_parameter_group" "mysql_pg" {
  name   = "${var.resource_grp_name}-param-grp"
  family = "mysql5.7"

  parameter {
    name  = "connect_timeout"
    value = "15"
  }

  # Full list of all parameters can be discovered via aws rds describe-db-parameters after initial creation of the group.

  #   parameter {
  #     ...
  #   }

  #   parameter {
  #     ...
  #   }
}