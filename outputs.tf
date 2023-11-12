# output "vpc_data" {
#   value = data.aws_vpcs.vpc.ids
# }

# output "subnets_data" {
#   value = data.aws_subnets.subnets.ids
# }

# output "vpc_secgrp_ecs" {
#   value = data.aws_security_group.vpc_secgrp.id
# }

output "db_endpoint" {
  value = aws_db_instance.rdsdb.address

  depends_on = [ aws_db_instance.rdsdb ]
}

output "db_endpoint_port" {
  value = aws_db_instance.rdsdb.port
}

