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

module "vm" {
  source = "github.com/Shadow-Lord123/Terraform_VM_GCP//vm?ref=main"

  project_id = var.project_id
  vm_name    = var.vm_name
  zone       = var.zone

  machine_type     = var.machine_type
  assign_public_ip = var.assign_public_ip

  boot_image        = var.boot_image
  boot_disk_size_gb = var.boot_disk_size_gb
  boot_disk_type    = var.boot_disk_type

  network_tags = var.network_tags
  labels       = var.labels
  metadata     = var.metadata
  subnetwork_self_link = module.vpc.subnetwork_self_link
  network_self_link = module.vpc.network_self_link

  startup_script = var.startup_script

  service_account_email  = var.service_account_email
  service_account_scopes = var.service_account_scopes
}

module "load_balancer" {
  source = "github.com/Shadow-Lord123/Terraform-Load-Balancer-GCP//load_balancer?ref=main"

  project_id = var.project_id
  zone       = var.zone
  environment = var.environment

  name_prefix = "web-lb"

  instance_self_link = module.vm.vm_self_link
  network_self_link  = module.vpc.network_self_link
  network_tags       = var.network_tags
}

module "gcs" {
  source = "github.com/Shadow-Lord123/Terraform-GCS-GCP//google_cloud_storage?ref=main"

  project_id  = var.project_id
  region      = var.region
  name_prefix = var.name_prefix
  environment = var.environment
  labels      = var.labels
}
