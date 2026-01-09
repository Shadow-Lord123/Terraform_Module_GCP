module "vpc" {
  source       = "./vpc"
  project_id  = var.project_id
  region      = var.region
  vpc_name    = var.vpc_name
  subnet_cidr = var.subnet_cidr
}

module "database" {
  source = "./database"

  project_id        = var.project_id
  region            = var.region
  db_name           = var.db_name
  db_user           = var.db_user
  db_password       = var.db_password
  subnet_cidr       = var.subnet_cidr
  network_self_link = module.vpc.network_self_link
  service_networking_connection_id  = module.vpc.service_networking_connection_id
}