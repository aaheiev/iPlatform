variable "env_name" {
  type    = string
  default = ""
}

variable "vpc_name" {
  type = string
}

variable "cloudrun_subnet_name" {
  type = string
}

variable "grafana_db_host" {
  type = string
}

variable "grafana_db_port" {
  type    = number
  default = 5432
}

variable "grafana_db_name" {
  type    = string
  default = "grafana"
}

variable "grafana_db_user" {
  type    = string
  default = "grafana"
}

variable "grafana_db_password_secret_name" {
  type    = string
  default = "grafana-db-password"
}

variable "grafana_admin_password_secret_name" {
  type    = string
  default = "grafana-admin-password"
}

variable "grafana_secret_key_secret_name" {
  type    = string
  default = "grafana-secret-key"
}

variable "grafana_container_image" {
  type    = string
  default = "grafana/grafana"
}

variable "grafana_container_image_version" {
  type    = string
  default = "11.4.0"
}

variable "grafana_container_port" {
  type    = number
  default = 3000
}

# variable "gke_cluster_name" {
#   type    = string
#   default = ""
# }
#
# variable "gke_location" {
#   type        = string
#   description = "The region or zone to run the cluster in. If empty - will use gke region"
#   default     = ""
# }
#
# variable "gke_release_channel" {
#   type        = string
#   description = "The GKE Release channel, defaults to UNSPECIFIED"
#   default     = "STABLE"
# }

# variable "remove_default_node_pool" {
#   description = "Remove the default node pool on creation, defaults to true. Set to false when importing existing cluster"
#   type        = bool
#   default     = true
# }
#
# variable "gke_autoscaling_profile" {
#   type        = string
#   description = "cluster_autoscaling.autoscaling_profile"
#   default     = "OPTIMIZE_UTILIZATION"
# }
#
# variable "gke_api_authorized_networks" {
#   type        = list(string)
#   description = "GKE authorized networks"
#   default     = []
# }
#
# variable "gke_default_sa_name" {
#   type        = string
#   default     = "default"
#   description = "GKE default node pools service account"
# }
#
# variable "gke_node_pools" {
#   type = map(object({
#     auto_upgrade                = bool
#     disk_size_gb                = number
#     disk_type                   = string
#     enable_integrity_monitoring = bool
#     enable_secure_boot          = bool
#     image_type                  = string
#     machine_type                = string
#     max_node_count              = number
#     min_cpu_platform            = string
#     min_node_count              = number
#     node_locations              = list(string)
#     node_type                   = string
#     oauth_scopes                = list(string)
#     preemptible                 = bool
#     tags                        = list(string)
#     taint_no_schedule           = string
#     version                     = string
#   }))
#   description = "Configuration the list of stateful (tainted) gke node pools."
#   default = {
#     default-pool = {
#       auto_upgrade                = true
#       disk_size_gb                = 24
#       disk_type                   = "pd-standard"
#       enable_integrity_monitoring = false
#       enable_secure_boot          = true
#       image_type                  = "COS_CONTAINERD"
#       machine_type                = "e2-medium"
#       max_node_count              = 5
#       min_cpu_platform            = null
#       min_node_count              = 1
#       node_locations              = []
#       node_type                   = ""
#       oauth_scopes                = []
#       preemptible                 = false
#       tags                        = null
#       taint_no_schedule           = ""
#       version                     = null
#     }
#   }
# }
#
# variable "gke_default_oauth_scopes" {
#   description = "Default list of GCP enabled APIs for node pool"
#   type        = list(string)
#   default = [
#     "https://www.googleapis.com/auth/devstorage.read_only",
#     "https://www.googleapis.com/auth/logging.write",
#     "https://www.googleapis.com/auth/monitoring",
#     "https://www.googleapis.com/auth/service.management.readonly",
#     "https://www.googleapis.com/auth/servicecontrol",
#     "https://www.googleapis.com/auth/trace.append"
#   ]
# }
