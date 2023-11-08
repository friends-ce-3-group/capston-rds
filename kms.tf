
resource "aws_kms_key" "kms_key" {
  description = "${var.proj_name} KMS Key for RDS Encryption"

  deletion_window_in_days = 30

  tags = {
    Name = "${var.proj_name} KMS Key"
  }

}