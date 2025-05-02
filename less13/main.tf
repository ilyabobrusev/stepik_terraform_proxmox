variable "environment" {
  default = "dev"
}

locals {
  memory = var.environment == "prod" ? 2048 : 1024
}

output "memory_size" {
  value = local.memory
}

variable "lxc_configs" {
  default = {
    web = { memory = 1024 }
  }
}

output "web_memory" {
  value = lookup(var.lxc_configs["web"], "memory", 512)
}

variable "custom_config" {
  default = {}
}

output "disk_size" {
  value = try(var.custom_config.disk, 10)
}
