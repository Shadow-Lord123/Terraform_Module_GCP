output "vpc_id" {
  value = google_compute_network.this.id
}

output "subnet_id" {
  value = google_compute_subnetwork.this.id
}

output "network_self_link" {
  value = google_compute_network.this.self_link
}

output "private_vpc_connection_id" {
  value = google_service_networking_connection.private_vpc_connection.id
}

output "service_networking_connection_id" {
  value = google_service_networking_connection.private_vpc_connection.id
}