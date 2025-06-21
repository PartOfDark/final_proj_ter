data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

# data "templatefile" "cloudinit" {
#   template = file("${path.module}/cloud-init.yaml.tpl")
#   vars = {
#     ssh_key       = var.ssh_pub_key
#     db_secret_ids = var.db_secret_ids
#     repo_url      = var.repo_url
#     repo_branch   = var.repo_branch
#     repo_path     = var.repo_path
#     cloud_id      = var.cloud_id
#     folder_id     = var.folder_id
#     zone          = var.zone
#   }
# }

resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "subnet_develop" {
  name           = var.subnet_name
  zone           = var.zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.subnet_cidr
}

resource "yandex_compute_instance" "web" {
  name        = var.vm_name
  zone        = var.zone
  platform_id = var.platform_id
  resources {
    cores         = var.cores
    memory        = var.memory
    core_fraction = var.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.disk_size
      type     = var.disk_type
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_develop.id
    nat       = true
    security_group_ids = [
      yandex_vpc_security_group.web.id,
    ]
  }
  metadata = {
    ssh-keys = "ubuntu:${var.ssh_pub_key}"
    user-data = templatefile("${path.module}/cloud-init.tpl", {
      ssh_key       = var.ssh_pub_key
      repo_url      = var.repo_url
      repo_branch   = var.repo_branch
      repo_path     = var.repo_path
      cloud_id      = var.cloud_id
      folder_id     = var.folder_id
      zone          = var.zone
      db_secret_ids = join(",", values(var.db_secret_ids))
    })
    serial-port-enable = 1
  }

  labels = {
    environment = "develop"
  }
}


resource "yandex_mdb_mysql_cluster" "db" {
  name        = var.mdb_props.name
  environment = var.mdb_props.environment
  network_id  = yandex_vpc_network.develop.id
  version     = var.mdb_props.version

  resources {
    resource_preset_id = var.mdb_props.resources.resource_preset_id
    disk_size          = var.mdb_props.resources.disk_size
    disk_type_id       = var.mdb_props.resources.disk_type_id
  }

  host {
    zone      = var.zone
    subnet_id = yandex_vpc_subnet.subnet_develop.id
    name      = "${var.mdb_props.name}-host-1"
  }
}
resource "yandex_mdb_mysql_user" "db_user" {
  cluster_id = yandex_mdb_mysql_cluster.db.id
  name       = var.mdb_props.user.name
  password   = var.mdb_props.user.password
}

resource "yandex_container_registry" "develop_registry" {
  name      = var.registry.name
  folder_id = var.folder_id

  labels = {
    my-label = "develop"
  }
}
