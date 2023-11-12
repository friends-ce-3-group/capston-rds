resource "aws_security_group" "rds_secgrp" {
  name   = "${var.resource_grp_name}-sg"
  vpc_id = local.vpc_id_found


  # allow access from all IP when publicly_accessible
  dynamic "ingress" {
    for_each = var.publicly_accessible ? [1] : []

    content {
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # allow access from selected security groups when not publicly_accessible
  dynamic "ingress" {
    for_each = var.publicly_accessible ? [] : [1]

    content {
      protocol        = "-1"
      from_port       = 0
      to_port         = 0
      security_groups = var.db_sg_allows_ingress_from_these_sg
    }
  }

  # ingress {
  #   protocol        = "-1"
  #   from_port       = 0
  #   to_port         = 0
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # ingress {
  #   protocol        = "-1"
  #   from_port       = 0
  #   to_port         = 0
  #   security_groups = var.db_sg_allows_ingress_from_these_sg
  # }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name      = "${var.resource_grp_name}-sg"
    proj_name = "${var.proj_name}"
  }
}

