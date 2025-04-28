terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

module "app" {
  source = "./modules/lxc_container"

  target_node    = "pve"
  vm_hostname    = "app-01"
  ostemplate     = "iso:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  ssh_public_key = file("./ssh/id_terraform.pub")
  private_key    = file("./ssh/id_terraform")
  ip_address     = "192.168.1.251/24"
  gateway        = "192.168.1.254"
  bridge         = "vmbr0"
  storage        = "vm"
  size           = "8G"

  lxc_resources = {
    cores  = 2
    memory = 2048
    swap   = 512
  }

}
