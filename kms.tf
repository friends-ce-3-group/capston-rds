data "aws_iam_policy_document" "kms_key" {
  statement {
    effect  = "Allow"
    actions = ["kms:*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::255945442255:root"]
    }
  }
}


resource "aws_kms_key" "kms_key" {

  count = var.kms_key_arn == null ? 1 : 0

  description = "${var.resource_grp_name} KMS Key for RDS Encryption"

  key_usage = "ENCRYPT_DECRYPT"

  customer_master_key_spec = "SYMMETRIC_DEFAULT"

  deletion_window_in_days = 30

  policy = data.aws_iam_policy_document.kms_key.json

  tags = {
    name      = "${var.resource_grp_name} KMS Key"
    proj_name = var.proj_name
  }

}