terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

resource "proxmox_lxc" "monitoring" {
  hostname         = "monitoring"
  ostemplate       = "iso:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  target_node      = "pve"
  password         = "password"
  cores            = 1
  memory           = 1024
  ssh_public_keys  = file("${path.module}/../../ssh/id_terraform.pub")

  rootfs {
    storage = "vm"
    size    = "8G"
  }

  network {
    name     = "eth0"
    bridge   = "vmbr0"
    ip       = var.prometheus_ip
    gw       = "192.168.1.254"
    firewall = true
  }

  start = true

}
