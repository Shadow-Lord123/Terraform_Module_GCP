variable "vm_name" {
  type        = string
  description = "Name of the VM"
}

variable "project_id" {
  type = string
}

variable "zone" {
  type        = string
  description = "GCP zone"
}

variable "machine_type" {
  type        = string
}

variable "boot_image" {
  type        = string
}

variable "boot_disk_size_gb" {
  type        = number
}

variable "boot_disk_type" {
  type        = string
}

variable "assign_public_ip" {
  type        = bool
}

variable "startup_script" {
  type        = string
}

variable "metadata" {
  type        = map(string)
}

variable "network_tags" {
  type        = list(string)
}

variable "service_account_email" {
  type        = string
}

variable "service_account_scopes" {
  type        = list(string)
}

variable "labels" {
  type        = map(string)
}

variable "subnetwork_self_link" {
  type        = string
  description = "Self link of the subnet to attach the VM to"
}

variable "network_self_link" {
  type = string
}