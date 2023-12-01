resource "aws_secretsmanager_secret" "rds_login" {
  name        = "${var.resource_grp_name}-rds-login"
  description = "Example secret stored in AWS Secrets Manager"
}

resource "aws_secretsmanager_secret_version" "example_secret_version" {
  secret_id = aws_secretsmanager_secret.rds_login.id
  secret_string = jsonencode({
    username = "${var.db_username}",
    password = "${var.db_pw}"
  })
}