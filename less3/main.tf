module "apps" {
  source = "./modules/lxc_dynamic"

  containers = {
    nginx01 = { ip = "192.168.1.251/24" }
    nginx02 = { ip = "192.168.1.252/24" }
  }

  bridge         = "vmbr0"
  ostemplate     = "iso:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  storage        = "vm"
  size           = "8G"
  target_node    = "pve"
  ssh_public_key = file("./ssh/id_terraform.pub")
  private_key    = file("./ssh/id_terraform")

  resources = {
    cores  = 2
    memory = 2048
    swap   = 512
  }
}

output "container_names" {
  value       = module.apps.container_names
  description = "Список имён контейнеров, созданных через модуль"
}
