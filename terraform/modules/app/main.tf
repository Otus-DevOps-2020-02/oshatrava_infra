# VM app instance
resource "google_compute_instance" "reddit_app_instance" {
  count        = var.vm_instance_count
  name         = "reddit-app-${count.index + 1}"
  machine_type = var.machine_type
  zone         = var.zone
  tags = [
    "reddit-app",
  ]
  boot_disk {
    initialize_params {
      image = var.app_disk_image
    }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.reddit_app_ip.address
    }
  }
  metadata = {
    ssh-keys = "olegshatrava:${file(var.public_key_path)}"
  }
}

# IP address
resource "google_compute_address" "reddit_app_ip" {
  name = "reddit-app-ip"
}

# Firewall rules
resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"
  allow {
    protocol = var.puma_protocol
    ports    = var.puma_ports
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
