output "grafana_service_address" {
  value = google_cloud_run_v2_service.app.uri
}
