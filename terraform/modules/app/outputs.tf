output "app_external_ip" {
  description = "External ip address of the app"
  value = google_compute_instance.reddit_app_instance[*].network_interface[0].access_config[0].nat_ip
}
