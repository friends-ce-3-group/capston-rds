resource "aws_secretsmanager_secret" "rds_login" {
  name        = "${var.resource_grp_name}-rds-login"
  description = "rds-login secret"
}

resource "aws_secretsmanager_secret_version" "rds_login_secret_version" {
  secret_id = aws_secretsmanager_secret.rds_login.id
  secret_string = jsonencode({
    username = "${var.db_username}",
    password = "${var.db_pw}"
  })
}