############################################
# IAP SSH Firewall Rule
############################################
resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "${var.vm_name}-allow-iap-ssh"
  project = var.project_id
  network = var.network_self_link

  direction = "INGRESS"
  priority  = 1000

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]

  target_tags = var.network_tags
}

############################################
# Compute VM
############################################
resource "google_compute_instance" "this" {
  name         = var.vm_name
  project      = var.project_id
  zone         = var.zone
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = var.boot_image
      size  = var.boot_disk_size_gb
      type  = var.boot_disk_type
    }
  }

  network_interface {
    subnetwork = var.subnetwork_self_link
  }

  # OS Login required for clean IAP SSH
  metadata = merge(
    var.metadata,
    {
      enable-oslogin = "TRUE"
    }
  )

  tags = var.network_tags

  service_account {
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }

  labels = var.labels

  depends_on = [
    google_compute_firewall.allow_iap_ssh
  ]
}
