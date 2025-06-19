terraform {
  required_version = ">= 1.8.4"

  backend "s3" {

    shared_credentials_files = ["~/.aws/credentials.ini"]
    #shared_config_files      = ["~/.aws/config"]
    profile = "default"
    region  = "ru-central1"

    bucket = "my-demo-bucket" #FIO-netology-tfstate
    key    = "dev/terraform.tfstate"


    # access_key                  = "..."          #Только для примера! Не хардкодим секретные данные!
    # secret_key                  = "..."          #Только для примера! Не хардкодим секретные данные!


    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
    skip_s3_checksum            = true # Необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.

    endpoints = {
      dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1g4rrcf3jq0fkd1d7h1/etnkm3n4su23p34nkrpb"
      s3       = "https://storage.yandexcloud.net"
    }

    dynamodb_table = "dev/table771"
  }
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
