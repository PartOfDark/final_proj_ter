output "web_sg_id" {
  value = yandex_vpc_security_group.web.id
}

output "web_sg_name" {
  value = yandex_vpc_security_group.web.name
}

output "db_address" {
  value = yandex_mdb_mysql_cluster.db.host[0].fqdn
}

output "db_port" {
  value = yandex_mdb_mysql_cluster.db.port
}

output "registry_url" {
  value = yandex_container_registry.develop_registry.repository_id
}
