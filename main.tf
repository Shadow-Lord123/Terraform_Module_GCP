module "vpc" {
  source       = "github.com/Shadow-Lord123/Terraform_VPC_GCP//vpc?ref=main"
  project_id  = var.project_id
  region      = var.region
  vpc_name    = var.vpc_name
  subnet_cidr = var.subnet_cidr
}

module "database" {
  source = "github.com/Shadow-Lord123/Terraform_Database_GCP//database?ref=main"

  project_id        = var.project_id
  region            = var.region
  db_name           = var.db_name
  db_user           = var.db_user
  db_password       = var.db_password
  subnet_cidr       = var.subnet_cidr
  network_self_link = module.vpc.network_self_link
  service_networking_connection_id  = module.vpc.service_networking_connection_id
}