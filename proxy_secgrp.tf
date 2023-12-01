# resource "aws_security_group" "rds_proxy_secgrp" {
#   name   = "${var.resource_grp_name}-proxy-sg"
#   vpc_id = local.vpc_id_found

#   ingress {
#     protocol        = "-1"
#     from_port       = 0
#     to_port         = 0
#     security_groups = [var.ecs_sg_id] # allow ingress from ECS service security group
#   }

#   egress {
#     protocol    = "-1"
#     from_port   = 0
#     to_port     = 0
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     name      = "${var.resource_grp_name}-proxy-sg"
#     proj_name = "${var.proj_name}"
#   }
# }

resource "aws_security_group_rule" "rdssg_self_ingress" {
  security_group_id = aws_security_group.rds_secgrp.id
  
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
}