variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "europe-west2"
}

variable "vpc_name" {
  type = string
}

variable "subnet_cidr" {
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
