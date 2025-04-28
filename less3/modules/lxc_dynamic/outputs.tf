output "container_names" {
  value = [for i in proxmox_lxc.containers : i.hostname]
  description = "Список имён контейнеров"
}

