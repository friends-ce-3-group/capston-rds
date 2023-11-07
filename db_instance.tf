resource "aws_db_instance" "mydb" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  db_name              = "mydb"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql5.7"

  vpc_security_group_ids = [data.aws_security_group.vpc_secgrp.id]
  db_subnet_group_name  =  aws_db_subnet_group.db_subnet_group.name

  skip_final_snapshot = true
}