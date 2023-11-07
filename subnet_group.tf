resource "aws_db_subnet_group" "db_subnet_group" {

  name = "${var.proj_name}-subnet-group"

  subnet_ids = data.aws_subnets.subnets.ids

  tags = {
    Name = "${var.proj_name}-subnet-group"
  }
}