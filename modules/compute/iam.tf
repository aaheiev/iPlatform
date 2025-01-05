resource "google_service_account" "app_sa" {
  project      = var.gcloud_project
  account_id   = "${local.env_name}-grafana"
  display_name = "${local.env_name}-grafana"
  description  = "Service account used by ${local.env_name} Service`"
}
