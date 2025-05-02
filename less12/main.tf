variable "lxc_memory_map" {
  default = {
    web = 1024
    db  = 2048
  }
}

output "nginx_memory" {
  value = lookup(var.lxc_memory_map, "nginx", 512)
}

variable "container_config" {
  default = {}
}

output "swap_size" {
  value = try(var.container_config.swap, 256)
}

variable "lxc_settings" {
  default = {}
}

output "ram" {
  value = try(var.lxc_settings.memory, 512)
}

variable "lxc_roles" {
  default = {
    frontend = 1024
    db       = 2048
  }
}

output "memory_for_web" {
  value = lookup(var.lxc_roles, "web", 768)
}
