variable "project" {
  type        = string
  description = "Project ID"
}

variable "region" {
  type        = string
  description = "Region"
  default     = "europe-west1"
}

variable "zone" {
  type        = string
  description = "Zone"
  default     = "europe-west1-b"
}

variable "public_key_path" {
  type        = string
  description = "Path to the public key used for ssh access"
}

variable "private_key_path" {
  type        = string
  description = "Path to the private key used for ssh access"
}

variable "app_disk_image" {
  type        = string
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable "db_disk_image" {
  type        = string
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

variable source_ranges {
  type        = list
  description = "Allowed IP addresses"
  default     = ["0.0.0.0/0"]
}
