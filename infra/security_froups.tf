variable "security_group_ingress" {
  description = "Ingress rules"
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  }))
  default = [
    {
      protocol       = "TCP"
      description    = "SSH"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 22
    },
    {
      protocol       = "TCP"
      description    = "HTTP"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 80
    },
    {
      protocol       = "TCP"
      description    = "HTTPS"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 443
    },
  ]
}

variable "security_group_egress" {
  description = "Egress rules"
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  }))
  default = [
    {
      protocol       = "TCP"
      description    = "All outbound TCP"
      v4_cidr_blocks = ["0.0.0.0/0"]
      from_port      = 0
      to_port        = 65535
    },
  ]
}


resource "yandex_vpc_security_group" "web" {
  name       = "web-sg"
  network_id = yandex_vpc_network.develop.id

  dynamic "ingress" {
    for_each = var.security_group_ingress
    content {
      description    = ingress.value.description
      protocol       = ingress.value.protocol
      port           = ingress.value.port
      from_port      = ingress.value.from_port
      to_port        = ingress.value.to_port
      v4_cidr_blocks = ingress.value.v4_cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.security_group_egress
    content {
      description    = egress.value.description
      protocol       = egress.value.protocol
      port           = egress.value.port
      from_port      = egress.value.from_port
      to_port        = egress.value.to_port
      v4_cidr_blocks = egress.value.v4_cidr_blocks
    }
  }
}
