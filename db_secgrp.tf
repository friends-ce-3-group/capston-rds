resource "aws_security_group" "rds_secgrp" {
  name   = "${var.resource_grp_name}-rds"
  vpc_id = local.vpc_id_found

  ingress {
    protocol        = "-1"
    from_port       = 0
    to_port         = 0
    security_groups = var.db_sg_allows_ingress_from_these_sg
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

