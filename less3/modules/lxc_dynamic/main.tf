terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

resource "proxmox_lxc" "containers" {
  for_each = var.containers

  hostname      = each.key
  ostemplate    = var.ostemplate
  target_node   = var.target_node
  password      = "password"
  ssh_public_keys = var.ssh_public_key

  cores  = var.resources.cores
  memory = var.resources.memory
  swap   = var.resources.swap

  rootfs {
    storage = var.storage
    size    = var.size
  }

  network {
    name     = "eth0"
    bridge   = var.bridge
    ip       = each.value.ip
    gw       = "192.168.1.254"
    firewall = true
  }

  start = true

  connection {
    type        = "ssh"
    host        = each.value.ip
    user        = "root"
    private_key = var.private_key
    timeout     = "2m"
  }
}
