############################################
# VPC
############################################
resource "google_compute_network" "this" {
  name                    = var.vpc_name
  project                 = var.project_id
  auto_create_subnetworks = false
}

############################################
# Subnet
############################################
resource "google_compute_subnetwork" "this" {
  name          = "${var.vpc_name}-subnet"
  project       = var.project_id
  region        = var.region
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.this.self_link
}

############################################
# Enable Service Networking API
############################################
resource "google_project_service" "service_networking" {
  project = var.project_id
  service = "servicenetworking.googleapis.com"
}

############################################
# Reserve IP range for Google-managed services
############################################
resource "google_compute_global_address" "private_service_range" {
  name          = "google-managed-services"
  project       = var.project_id
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.this.self_link
}

############################################
# Create Service Networking VPC peering
############################################
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.this.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.private_service_range.name
  ]

  depends_on = [
    google_project_service.service_networking
  ]
}
