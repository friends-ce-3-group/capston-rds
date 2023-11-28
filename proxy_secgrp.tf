resource "aws_security_group" "rds_proxy_secgrp" {
  name   = "${var.resource_grp_name}-proxy-sg"
  vpc_id = local.vpc_id_found

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    security_groups = [var.ecs_sg_id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name      = "${var.resource_grp_name}-proxy-sg"
    proj_name = "${var.proj_name}"
  }
}

