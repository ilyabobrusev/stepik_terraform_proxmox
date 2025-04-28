resource "proxmox_lxc" "demo" {
  count       = var.vm_count
  hostname    = "demo-${count.index + 1}"
  ostemplate  = "iso:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  target_node = "pve"
  password    = "password"
  cores       = 1
  memory      = 512
  swap        = 256

  ssh_public_keys = file("./ssh/id_terraform.pub")

  rootfs {
    storage = "vm"
    size    = "4G"
  }

  network {
    name     = "eth0"
    bridge   = "vmbr0"
    ip       = "192.168.1.${count.index + 251}/24"
    gw       = "192.168.1.254"
    firewall = true
  }

  start = true

  connection {
    type        = "ssh"
    host        = "192.168.1.${count.index + 251}"
    user        = "root"
    private_key = file("./ssh/id_terraform")
    timeout     = "2m"
  }
}

output "container_names" {
  value = [for i in proxmox_lxc.demo : {
    name = i.hostname
    ip = i.network[0].ip
  }]
  description = "Список имён контейнеров"
}
