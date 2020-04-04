output "db_external_ip" {
  value = google_compute_instance.reddit_db_instance[*].network_interface[0].access_config[0].nat_ip
}
