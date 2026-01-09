terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "terraform-project-483311"
  region  = "europe-west2"
  zone    = "europe-west2-a"
}