# VM app instance
resource "google_compute_instance" "reddit_app_instance" {
  name         = "reddit-app"
  machine_type = "g1-small"
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
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}
