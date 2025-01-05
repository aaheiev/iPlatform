resource "random_id" "index" {
  byte_length = 4
}

locals {
  name = var.service_name == "" ? "app-${random_id.index.hex}-${var.gcloud_region}" : var.service_name
}

output "name" {
  value = local.name
}
