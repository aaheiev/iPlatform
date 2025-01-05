variable "service_name" {
  type    = string
  default = ""
}

variable "gcloud_project" {
  type        = string
  description = "Main GCP project"
}

variable "gcloud_region" {
  type        = string
  description = "GCP region to run service in"
  default     = "europe-west4"
}
