# locals {
#   zone                       = data.google_compute_zones.available.names[length(data.google_compute_zones.available.names) - 2]
#   test_instance_name         = "my-vm-instance"
#   test_instance_machine_type = "e2-micro"
#   test_instance_image = "ubuntu-os-cloud/ubuntu-2204-lts"
# }
#
# resource "google_compute_firewall" "default_ssh" {
#   name    = "${google_compute_network.vpc.name}-default-ssh"
#   network = google_compute_network.vpc.name
#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }
#   target_tags = ["ssh"]
# }
#
# resource "google_compute_instance" "test_instance" {
#   name                       = local.test_instance_name
#   tags                       = ["ssh"]
#   zone                       = local.zone
#   machine_type               = local.test_instance_machine_type
#   deletion_protection        = false
#   enable_display             = false
#   key_revocation_action_type = "NONE"
#   allow_stopping_for_update  = true
#   network_interface {
#     network    = google_compute_network.vpc.id
#     subnetwork = google_compute_subnetwork.gke_subnet.id
#   }
#   boot_disk {
#     initialize_params {
#       image = local.test_instance_image
#     }
#   }
#   reservation_affinity {
#     type = "ANY_RESERVATION"
#   }
#   scheduling {
#     automatic_restart   = true
#     min_node_cpus       = 0
#     on_host_maintenance = "MIGRATE"
#     preemptible         = false
#     provisioning_model  = "STANDARD"
#   }
#   shielded_instance_config {
#     enable_integrity_monitoring = true
#     enable_secure_boot          = true
#     enable_vtpm                 = true
#   }
# }
#
# import {
#   id = "${var.gcloud_project}/${local.zone}/${local.test_instance_name}"
#   to = google_compute_instance.test_instance
# }
