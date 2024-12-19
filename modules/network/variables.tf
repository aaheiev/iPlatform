variable "gcloud_project" {
  type        = string
  description = "Main GCP project"
}

variable "gcloud_region" {
  type        = string
  description = "Main GCP region"
  default     = "europe-west4"
}

variable "env_name" {
  type    = string
  default = ""
}

variable "ipv4_cidr" {
  type    = string
  default = "10.95.0.0/16"
}

variable "nat_ip_addresses_count" {
  type    = number
  default = 1
}
