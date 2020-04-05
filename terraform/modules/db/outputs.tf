output "db_external_ip" {
  description = "External IP address of the DB"
  value = google_compute_instance.reddit_db_instance[*].network_interface[0].access_config[0].nat_ip
}

output "db_local_ip" {
  description = "Local IP address of the DB"
  value = google_compute_instance.reddit_db_instance[*].network_interface[0].network_ip
}
