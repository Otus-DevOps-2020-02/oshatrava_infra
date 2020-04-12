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

variable "db_disk_image" {
  type        = string
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
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

variable "mongo_protocol" {
  description = "MongoDB protocol"
  default = "tcp"
}

variable "mongo_ports" {
  description = "MongoDB port"
  default = ["27017"]
}
