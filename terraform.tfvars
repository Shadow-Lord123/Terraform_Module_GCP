project_id  = "terraform-project-483311"
vpc_name    = "db-vpc"
subnet_cidr = "10.50.0.0/24"

db_name     = "appdb"
db_user     = "appuser"
db_password = "ChangeMe123!"

vm_name = "terraform-vm"
zone    = "europe-west2-a"

machine_type       = "e2-micro"
boot_image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
boot_disk_size_gb  = 20
boot_disk_type     = "pd-balanced"

assign_public_ip = false

startup_script = null
metadata       = {}

network_tags = ["internal-vm"]

service_account_email = null
service_account_scopes = [
  "https://www.googleapis.com/auth/cloud-platform"
]

labels = {
  environment = "dev"
}

