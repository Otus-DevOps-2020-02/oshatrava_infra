output "app_external_ip" {
  value = module.app.app_external_ip
}

output "app_local_ip" {
  value = module.app.app_local_ip
}

output "db_external_ip" {
  value = module.db.db_external_ip
}

output "db_local_ip" {
  value = module.db.db_local_ip
}
