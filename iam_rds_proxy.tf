data "aws_secretsmanager_secret" "db_access" {
  name = "friendscapstonerds/mysql"
}

data "aws_iam_policy_document" "rds_access_secretsmgr" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetRandomPassword",
      "secretsmanager:CreateSecret",
      "secretsmanager:ListSecrets"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:*"
    ]
    resources = [data.aws_secretsmanager_secret.db_access.arn]
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


data "aws_iam_policy_document" "rds_access_secrets_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "rdsproxy_secrets_role" {
  name = "${var.resource_grp_name}-rdsproxy-secrets-role"

  assume_role_policy = data.aws_iam_policy_document.rds_access_secrets_assume_role.json

  tags = {
    name      = "${var.resource_grp_name}-rdsproxy-secrets-role"
    proj_name = var.proj_name
  }
}

resource "aws_iam_role_policy_attachment" "attach_rdsproxy_secrets_policy_to_role" {
  role       = aws_iam_role.rdsproxy_secrets_role.name
  policy_arn = aws_iam_policy.rdsproxy_secrets_policy.arn
}