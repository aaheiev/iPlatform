data "google_iam_policy" "secret_accessor" {
  binding {
    role = "roles/secretmanager.secretAccessor"
    members = [
      "serviceAccount:${google_service_account.app_sa.email}",
    ]
  }
}

data "google_secret_manager_secret" "grafana_db_password" {
  project   = data.google_project.gcloud_project.project_id
  secret_id = var.grafana_db_password_secret_name
}

resource "google_secret_manager_secret_iam_policy" "grafana_db_password_secret_accessor" {
  project     = data.google_project.gcloud_project.project_id
  secret_id   = data.google_secret_manager_secret.grafana_db_password.secret_id
  policy_data = data.google_iam_policy.secret_accessor.policy_data
}

data "google_secret_manager_secret" "grafana_admin_password" {
  project   = data.google_project.gcloud_project.project_id
  secret_id = var.grafana_admin_password_secret_name
}

resource "google_secret_manager_secret_iam_policy" "grafana_admin_password_secret_accessor" {
  project     = data.google_project.gcloud_project.project_id
  secret_id   = data.google_secret_manager_secret.grafana_admin_password.secret_id
  policy_data = data.google_iam_policy.secret_accessor.policy_data
}

data "google_secret_manager_secret" "grafana_secret_key" {
  project   = data.google_project.gcloud_project.project_id
  secret_id = var.grafana_secret_key_secret_name
}

resource "google_secret_manager_secret_iam_policy" "grafana_secret_key_secret_accessor" {
  project     = data.google_project.gcloud_project.project_id
  secret_id   = data.google_secret_manager_secret.grafana_secret_key.secret_id
  policy_data = data.google_iam_policy.secret_accessor.policy_data
}
