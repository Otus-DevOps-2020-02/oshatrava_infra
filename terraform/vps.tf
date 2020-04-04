# Firewall rules
resource "google_compute_firewall" "firewall_ssh" {
  name        = "default-allow-ssh"
  description = "Allow SSH rule"
  network     = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

# Metadata
resource "google_compute_project_metadata_item" "ssh-keys" {
  key   = "ssh-keys"
  value = "olegshatrava:${file(var.public_key_path)}}"
}
