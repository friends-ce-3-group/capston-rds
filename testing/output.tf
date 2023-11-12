resource "local_file" "write_url" {
  filename = "${path.module}/RDS_ADDRESS.dat"

  content  = <<-EOT
    RDS_ADDRESS_URL=${module.rds.db_endpoint}
    RDS_DBNAME=${var.db_name}
  EOT

}