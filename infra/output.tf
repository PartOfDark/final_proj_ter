output "web_sg_id" {
  value = yandex_vpc_security_group.web.id
}

output "web_sg_name" {
  value = yandex_vpc_security_group.web.name
}

output "db_address" {
  value = yandex_mdb_mysql_cluster.db.host
}

output "db_port" {
  value = 3306
}

output "registry_url" {
  value = "cr.yandex/${yandex_container_registry.develop_registry.id}"
}
