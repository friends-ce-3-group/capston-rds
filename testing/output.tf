resource "local_file" "write_url" {
  content  = "RDS_ADDRESS=${module.rds.db_endpoint}"
  filename = "${path.module}/RDS_ADDRESS.dat"
}