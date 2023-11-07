output "vpc_data" {
  value = data.aws_vpcs.vpc.ids
}

output "subnets_data" {
  value = data.aws_subnets.subnets.ids
}

output "vpc_secgrp_ecs" {
  value = data.aws_security_group.vpc_secgrp.id
}