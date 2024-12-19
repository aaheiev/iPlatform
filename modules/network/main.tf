locals {
  env_name          = var.env_name == "" ? terraform.workspace : var.env_name
  vpc_name          = "iplatform-${local.env_name}"
  gke_subnet_name   = "${local.env_name}-gke-${var.gcloud_region}"
  l7lb_subnet_name  = "${local.env_name}-l7lb-${var.gcloud_region}"
  nat_subnet_name   = "${local.env_name}-nat-${var.gcloud_region}"
  gke_pods_cidr     = cidrsubnet(var.ipv4_cidr, 4, 0)
  gke_services_cidr = cidrsubnet(var.ipv4_cidr, 5, 2)
  gke_subnet_cidr   = cidrsubnet(var.ipv4_cidr, 5, 3)
  l7lb_subnet_cidr  = cidrsubnet(var.ipv4_cidr, 6, 8)
  nat_subnet_cidr   = cidrsubnet(var.ipv4_cidr, 6, 9)
}

data "google_compute_zones" "available" {
  region = var.gcloud_region
}

resource "google_compute_network" "vpc" {
  provider                = google-beta
  name                    = local.vpc_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "gke_subnet" {
  provider      = google-beta
  name          = local.gke_subnet_name
  ip_cidr_range = local.gke_subnet_cidr
  region        = var.gcloud_region
  network       = google_compute_network.vpc.id
  secondary_ip_range {
    range_name    = "pods-subnet"
    ip_cidr_range = local.gke_pods_cidr
  }
  secondary_ip_range {
    range_name    = "services-subnet"
    ip_cidr_range = local.gke_services_cidr
  }
}

resource "google_compute_address" "nat_ip_addresses" {
  count  = var.nat_ip_addresses_count
  name   = "${local.env_name}-nat-ip-${count.index}-${var.gcloud_region}"
  region = var.gcloud_region
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_router" "router" {
  name    = "${local.env_name}-router-${var.gcloud_region}"
  region  = var.gcloud_region
  network = google_compute_network.vpc.id
}

resource "google_compute_router_nat" "cloud_nat" {
  name                               = "${local.env_name}-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = google_compute_address.nat_ip_addresses.*.self_link
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.gke_subnet.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

/*
resource "google_compute_subnetwork" "l7lb_subnet" {
  provider      = google-beta
  region        = var.gcloud_region
  name          = local.l7lb_subnet_name
  ip_cidr_range = local.l7lb_subnet_cidr
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  network       = google_compute_network.vpc.id
}

resource "google_compute_subnetwork" "nat_subnet" {
  provider      = google-beta
  region        = var.gcloud_region
  name          = local.nat_subnet_name
  ip_cidr_range = local.nat_subnet_cidr
  purpose       = "PRIVATE_NAT"
  network       = google_compute_network.vpc.id
}
*/
