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
  source          = "./modules/app"
  zone            = var.zone
  public_key_path = var.public_key_path
  app_disk_image  = var.app_disk_image
}

module "db" {
  source          = "./modules/db"
  zone            = var.zone
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
}

module "vps" {
  source        = "./modules/vps"
  source_ranges = var.source_ranges
}
