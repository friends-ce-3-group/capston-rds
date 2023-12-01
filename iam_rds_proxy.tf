# data "aws_secretsmanager_secret" "db_access" {
#   name = "friends-capstone-rds/mysql" # existing secret
# }

data "aws_iam_policy_document" "rds_access_secretsmgr" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "rdsproxy_secrets_policy" {
  name = "${var.resource_grp_name}-rdsproxy-secrets-policy"

  policy = data.aws_iam_policy_document.rds_access_secretsmgr.json

  tags = {
    name      = "${var.resource_grp_name}-rdsproxy-secrets-policy"
    proj_name = var.proj_name
  }
}

resource "aws_iam_role" "rdsproxy_secrets_role" {
  name = "${var.resource_grp_name}-rdsproxy-secrets-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "rds.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    name      = "${var.resource_grp_name}-rdsproxy-secrets-role"
    proj_name = var.proj_name
  }
}

resource "aws_iam_role_policy_attachment" "attach_rdsproxy_secrets_policy_to_role" {
  role       = aws_iam_role.rdsproxy_secrets_role.name
  policy_arn = aws_iam_policy.rdsproxy_secrets_policy.arn
}