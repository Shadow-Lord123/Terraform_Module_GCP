
output "db_instance_name" {
  value = google_sql_database_instance.this.name
}

output "db_name" {
  value = google_sql_database.this.name
}
