
resource "aws_kms_key" "kms_key" {
  description = "${var.resource_grp_name} KMS Key for RDS Encryption"

  deletion_window_in_days = 30

  tags = {
    Name = "${var.resource_grp_name} KMS Key"
  }

}