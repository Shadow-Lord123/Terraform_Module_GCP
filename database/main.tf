########################################
# CLOUD SQL INSTANCE
########################################

resource "google_sql_database_instance" "this" {
  name             = "standalone-postgres"
  project          = var.project_id
  region           = var.region
  database_version = "POSTGRES_14"

  depends_on = [
    var.service_networking_connection_id
  ]

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network_self_link
    }
  }

  deletion_protection = false
}


########################################
# DATABASE
########################################

resource "google_sql_database" "this" {
  name     = var.db_name
  instance = google_sql_database_instance.this.name
}

########################################
# USER
########################################

resource "google_sql_user" "this" {
  name     = var.db_user
  instance = google_sql_database_instance.this.name
  password = var.db_password
}

########################################
# FIREWALL RULE (VPC-AWARE)
########################################

resource "google_compute_firewall" "allow_postgres_db" {
  name    = "allow-postgres-db"
  project = var.project_id
  network = var.network_self_link

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_ranges = [var.subnet_cidr]
}