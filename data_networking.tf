data "aws_vpcs" "vpc" {
  tags = {
    Name = "${var.proj_name_root}-*"
  }
}


data "aws_subnets" "subnets" {

  filter {
    name   = "vpc-id"
    values = data.aws_vpcs.vpc.ids
  }

  filter {
    name   = "map-public-ip-on-launch"
    values = [false]
  }

}

locals {
  vpc_id_found = element(data.aws_vpcs.vpc.ids, 0)
}