resource "aws_db_proxy" "db_proxy" {
  name                   = "${var.resource_grp_name}-rds-dbproxy"
  debug_logging          = true
  engine_family          = "MYSQL"
  idle_client_timeout    = 1800
  require_tls            = false
  role_arn               = aws_iam_role.rdsproxy_secrets_role.arn
  vpc_security_group_ids = [aws_security_group.rds_proxy_secgrp.id]
  vpc_subnet_ids         = data.aws_subnets.private_subnets.ids

  auth {
    auth_scheme = "SECRETS"
    description = "using DB secrets stored in Secrets Manager"
    iam_auth    = "DISABLED"
    secret_arn  = data.aws_secretsmanager_secret.db_access.arn
  }

  tags = {
    name = "${var.resource_grp_name}-rds-dbproxy"
    proj_name  = var.proj_name
  }
}