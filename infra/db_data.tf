data "yandex_lockbox_secret_version" "db_host" {
  secret_id = var.db_secret_ids[0]
}
data "yandex_lockbox_secret_version" "db_user" {
  secret_id = var.db_secret_ids[1]
}
data "yandex_lockbox_secret_version" "db_password" {
  secret_id = var.db_secret_ids[2]
}
data "yandex_lockbox_secret_version" "db_database" {
  secret_id = var.db_secret_ids[3]
}
data "yandex_lockbox_secret_version" "db_table" {
  secret_id = var.db_secret_ids[4]
}
data "yandex_lockbox_secret_version" "db_root_password" {
  secret_id = var.db_secret_ids[5]
}
