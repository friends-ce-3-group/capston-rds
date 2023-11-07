data "aws_vpcs" "vpc" {
  tags = {
    Name = "${var.proj_name_root}-*"
  }
}

output "vpc_data" {
  value = data.aws_vpcs.vpc.ids
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

output "subnets_data" {
  value = data.aws_subnets.subnets.ids
}