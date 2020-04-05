terraform {
  required_version = "~> 0.12"
}

# Configure GCP
provider "google" {
  version = "~> 2.15"
  project = var.project
  region  = var.region
}

# Modules
module "app" {
  source          = "../modules/app"
  zone            = var.zone
  app_disk_image  = var.app_disk_image
  public_key_path = var.public_key_path
}

module "db" {
  source          = "../modules/db"
  zone            = var.zone
  db_disk_image   = var.db_disk_image
  public_key_path = var.public_key_path
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}
