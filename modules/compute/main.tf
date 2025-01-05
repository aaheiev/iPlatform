data "google_compute_zones" "available" {
  region = var.gcloud_region
}

data "google_project" "gcloud_project" {
  project_id = var.gcloud_project
}

locals {
  env_name = var.env_name == "" ? terraform.workspace : var.env_name
}

data "google_compute_network" "vpc" {
  name = var.vpc_name
}

data "google_compute_subnetwork" "cloudrun_subnet" {
  name   = var.cloudrun_subnet_name
  region = var.gcloud_region
}
