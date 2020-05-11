variable "zone" {
  type        = string
  description = "Zone"
  default     = "europe-west1-b"
}

variable "vm_instance_count" {
  type        = string
  description = "Create count instances"
  default     = "1"
}

variable "app_disk_image" {
  type        = string
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable "machine_type" {
  type        = string
  description = "Machine type"
  default = "g1-small"
}

variable "public_key_path" {
  type        = string
  description = "Path to the public key used for ssh access"
}

variable "puma_protocol" {
  description = "Puma app protocol"
  default = "tcp"
}

variable "puma_ports" {
  description = "Puma app port"
  default = ["9292", "80"]
}
