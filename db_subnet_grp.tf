# The DB subnet group defines which subnets and IP ranges 
# the DB instance can use in the VPC that you selected.
resource "aws_db_subnet_group" "db_subnet_group" {

  name = "${var.resource_grp_name}-subnet-group"

  subnet_ids = data.aws_subnets.pvt_subnets.ids # use the IPs in the private subnet

  tags = {
    Name = "${var.resource_grp_name}-subnet-group"
  }
}