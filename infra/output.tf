output "web_sg_id" {
  value = yandex_vpc_security_group.web.id
}

output "web_sg_name" {
  value = yandex_vpc_security_group.web.name
}

output "db_host" {
  value = yandex_mdb_mysql_cluster.db.host
}

output "registry_id" {
  value = yandex_container_registry.develop_registry.id
}

output "registry_url" {
  value = "cr.yandex/${yandex_container_registry.develop_registry.id}"
}
