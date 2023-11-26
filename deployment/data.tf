data "aws_vpc" "vpc" {
  tags = {
    Name = "${var.proj_name}-vpc"
  }
}

data "aws_security_group" "vpc_sg_alb" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    name    = "${var.proj_name}-ecs-shared-sg",
    project = "${var.proj_name}"
  }
}

data "aws_security_group" "vpc_sg_ecstask" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    name    = "${var.proj_name}-crud-api-*",
    project = "${var.proj_name}"
  }
}

locals {
  vpc_sg_ids = [
    data.aws_security_group.vpc_sg_alb.id,
    data.aws_security_group.vpc_sg_ecstask.id
  ]
}