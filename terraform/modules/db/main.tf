# VM db instance
resource "google_compute_instance" "reddit_db_instance" {
  count        = var.vm_instance_count
  name         = "reddit-db-${count.index + 1}"
  machine_type = var.machine_type
  zone         = var.zone
  tags = [
    "reddit-db",
  ]
  boot_disk {
    initialize_params {
      image = var.db_disk_image
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }
  metadata = {
    ssh-keys = "olegshatrava:${file(var.public_key_path)}"
  }
}

# Firewall rules
resource "google_compute_firewall" "firewall_mongo" {
  name    = "allow-mongo-default"
  network = "default"
  allow {
    protocol = var.mongo_protocol
    ports    = var.mongo_ports
  }
  target_tags = ["reddit-db"]
  source_tags = ["reddit-app"]
}
