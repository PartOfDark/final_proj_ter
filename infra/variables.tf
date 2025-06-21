variable "zone" {
  type    = string
  default = "ru-central1-b"
}
variable "subnet_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "vpc_name" {
  type    = string
  default = "develop"
}

variable "subnet_name" {
  type    = string
  default = "subnet_develop"
}
# variable "token" {
#   type        = string
#   description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
# }

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "vm_name" {
  type    = string
  default = "web"
}

variable "ssh_path" {
  type        = string
  description = "Path to SSH public key file"
  #default     = "~/.ssh/id_ed25519.pub"
}

variable "ssh_pub_key" {
  type        = string
  description = "Публичный SSH-ключ, передаваемый из GitHub Secrets"
}

variable "platform_id" {
  type    = string
  default = "standard-v3"
}

variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 2
}

variable "core_fraction" {
  type    = number
  default = 20
}

variable "disk_type" {
  type    = string
  default = "network-hdd"

}

variable "disk_size" {
  type    = number
  default = 20
}

variable "image_family" {
  type    = string
  default = "ubuntu-2204-lts"
}

variable "mdb_props" {
  type = object({
    name        = string
    environment = string
    version     = string
    user = object({
      name     = string
      password = string
    })
    resources = object({
      resource_preset_id = string
      disk_size          = number
      disk_type_id       = string
    })
  })
  default = {
    name        = "app-db"
    environment = "PRESTABLE"
    version     = "8.0"
    user = {
      name     = "appuser"
      password = "password" #BE CAREFUL! This is a default password, change it in production!
      #IF YOU DONT CHANGE IT, YOUR ASS WILL BE KICKED!
    }
    resources = {
      resource_preset_id = "s2.micro"
      disk_size          = 20
      disk_type_id       = "network-hdd"
    }
  }

}

variable "registry" {
  type = object({
    name      = string
    folder_id = string
    labels    = map(string)
  })
  default = {
    name      = "default-registry"
    folder_id = "default_folder_id"
    labels = {
      my-label = "default"
    }
  }
}

variable "sa_key_b64" {
  type      = string
  sensitive = true
}

variable "repo_url" {
  type    = string
  default = "https://github.com/PartOfDark/final_proj_ter.git"
}

variable "repo_branch" {
  type    = string
  default = "master"
}

variable "repo_path" {
  type    = string
  default = "app"
}

# variable "db_secret_ids" {
#   description = "LockBox IDs для каждого секрета (ключи должны совпадать с тем, как вы их используете в cloud-init)"
#   type        = map(string)
#   default = {
#     DB_HOST          = "e6qhm6fsibgkkgssrrn1"
#     DB_USER          = "e6qer673j31g3jf27vca"
#     DB_PASSWORD      = "e6qd7st67mr2fib931a5"
#     DB_DATABASE      = "e6qbdnboe8sv9o230vmi"
#     DB_TABLE         = "e6qcukmn90jp6ipqasfd"
#     DB_ROOT_PASSWORD = "e6qk5ck8bm5209kdq931"
#   }
# }

# variable "registry_id" {
#   type = string
# }

variable "db_host_secret_id" {
  description = "Lockbox Secret ID для DB_HOST"
  type        = string
  default     = "e6qhm6fsibgkkgssrrn1"
}

variable "db_user_secret_id" {
  description = "Lockbox Secret ID для DB_USER"
  type        = string
  default     = "e6qer673j31g3jf27vca"
}

variable "db_password_secret_id" {
  description = "Lockbox Secret ID для DB_PASSWORD"
  type        = string
  default     = "e6qd7st67mr2fib931a5"
}

variable "db_database_secret_id" {
  description = "Lockbox Secret ID для DB_DATABASE"
  type        = string
  default     = "e6qbdnboe8sv9o230vmi"
}

variable "db_table_secret_id" {
  description = "Lockbox Secret ID для DB_TABLE"
  type        = string
  default     = "e6qcukmn90jp6ipqasfd"
}

variable "db_root_password_secret_id" {
  description = "Lockbox Secret ID для DB_ROOT_PASSWORD"
  type        = string
  default     = "e6qk5ck8bm5209kdq931"
}
