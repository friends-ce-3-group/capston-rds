resource "aws_security_group" "vpc_secgrp" {
  name   = "${var.proj_name}-rds"
  vpc_id = local.vpc_id_found

  ingress {
    protocol        = "-1"
    from_port       = 0
    to_port         = 0
    security_groups = [data.aws_security_group.vpc_secgrp.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_security_group" "vpc_secgrp" {
  vpc_id = local.vpc_id_found

  tags = {
    name   = "${var.proj_name_root}-*",
    subnet = "private"
  }
}

