terraform {
  required_version = "~> 0.12"
}

# Configure GCP
provider "google" {
  version = "~> 2.15"
  project = var.project
  region  = var.region
}

# GCI create instance
resource "google_compute_instance" "reddit_app_instance" {
  count        = var.vm_instance_count
  name         = "reddit-app${count.index}"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  connection {
    type        = "ssh"
    host        = self.network_interface[0].access_config[0].nat_ip
    user        = "olegshatrava"
    agent       = false
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

# GCI metadata
resource "google_compute_project_metadata_item" "ssh-keys" {
  key   = "ssh-keys"
  value = "olegshatrava:${file(var.public_key_path)}appuser1:${file(var.public_key_path)}appuser2:${file(var.public_key_path)}"
}

# GCI firewall
resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
