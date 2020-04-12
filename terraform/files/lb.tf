resource "google_compute_instance_group" "reddit_app_group" {
  name        = "reddit-app-group"
  description = "Reddit App Instance group"

  instances = "${google_compute_instance.reddit_app_instance.*.self_link}"

  named_port {
    name = "http"
    port = "9292"
  }

  zone = var.zone
}

resource "google_compute_backend_service" "reddit_backend_service" {
  name        = "reddit-backend-service"
  description = "Backend service for reddit-app"
  port_name   = "http"
  protocol    = "HTTP"

  backend {
    group           = google_compute_instance_group.reddit_app_group.self_link
    max_utilization = 0.7
  }

  health_checks = [
    google_compute_http_health_check.reddit_health_check.self_link,
  ]
}

resource "google_compute_http_health_check" "reddit_health_check" {
  name         = "reddit-http-health-check"
  request_path = "/"
  port         = 9292
}

resource "google_compute_url_map" "reddit_url_map" {
  name        = "reddit-app-url-map"
  description = "Reddit map URL redirect traffic to the backend service"

  default_service = google_compute_backend_service.reddit_backend_service.self_link
}

resource "google_compute_target_http_proxy" "reddit_http_proxy" {
  name        = "reddit-app-http-proxy"
  description = "Target HTTP proxy"
  url_map     = google_compute_url_map.reddit_url_map.self_link
}

resource "google_compute_global_forwarding_rule" "reddit_forwarding_rule" {
  name        = "reddit-app-forwarding-rule"
  description = "Global forwarding rule"
  target      = google_compute_target_http_proxy.reddit_http_proxy.self_link
  port_range  = "80"
}
