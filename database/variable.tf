variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "network_self_link" {
  type = string
}

variable "subnet_cidr" {
  type = string
}

variable "service_networking_connection_id" {
  type = string
}
