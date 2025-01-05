resource "google_storage_bucket" "grafana_data" {
  name          = local.storage_bucket_name
  location      = "EU"
  force_destroy = true
}

resource "google_storage_bucket_iam_member" "grafana_storage_admin" {
  bucket     = google_storage_bucket.grafana_data.name
  role       = "roles/storage.admin"
  member     = "serviceAccount:${google_service_account.app_sa.email}"
  depends_on = [google_storage_bucket.grafana_data]
}
