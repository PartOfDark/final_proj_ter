terraform {
  required_version = ">= 1.8.4"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.142.0"
    }
  }
}
provider "yandex" {
  service_account_key_file = file("~/.key.json")
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}
