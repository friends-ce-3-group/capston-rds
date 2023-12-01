resource "aws_db_proxy" "db_proxy" {
  name                = "${var.resource_grp_name}-rds-dbproxy"
  debug_logging       = true
  engine_family       = "MYSQL"
  idle_client_timeout = 1800
  require_tls         = false
  role_arn            = aws_iam_role.rdsproxy_secrets_role.arn
  # vpc_security_group_ids = [aws_security_group.rds_proxy_secgrp.id]
  vpc_security_group_ids = [aws_security_group.rds_secgrp.id]
  vpc_subnet_ids         = data.aws_subnets.private_subnets.ids

  auth {
    auth_scheme               = "SECRETS"
    client_password_auth_type = "MYSQL_NATIVE_PASSWORD"
    description               = "using DB secrets stored in Secrets Manager"
    iam_auth                  = "DISABLED"
    secret_arn                = aws_secretsmanager_secret.rds_login.arn
  }

  tags = {
    name      = "${var.resource_grp_name}-rds-dbproxy"
    proj_name = var.proj_name
  }
}

resource "aws_cloudwatch_log_group" "rdsproxy_log_group" {
  name              = "/aws/rds/proxy/${var.resource_grp_name}-rds-dbproxy"
  retention_in_days = 0
}

resource "aws_db_proxy_default_target_group" "rdsproxy_target_group" {
  db_proxy_name = aws_db_proxy.db_proxy.name

  connection_pool_config {
    max_connections_percent      = 100
    max_idle_connections_percent = 10
    connection_borrow_timeout    = 120
  }
}

resource "aws_db_proxy_target" "rdsproxy_target" {
  db_instance_identifier = aws_db_instance.rdsdb.identifier
  db_proxy_name          = aws_db_proxy.db_proxy.name
  target_group_name      = aws_db_proxy_default_target_group.rdsproxy_target_group.name
}
