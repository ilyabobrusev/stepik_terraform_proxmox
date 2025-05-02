locals {
  ssh_key = file("${path.module}/ssh/id_terraform.pub")
  install_cmd = templatefile("${path.module}/templates/install.tpl", {
    package = "nginx"
  })
}

resource "proxmox_lxc" "ct" {
  hostname        = "ct-web01"
  target_node     = "pve"
  ostemplate      = "iso:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  password        = "password"
  ssh_public_keys = local.ssh_key
  memory          = 1024
  cores           = 2
  start           = true

  rootfs {
    storage = "vm"
    size    = "8G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "192.168.1.251/24"
    gw     = "192.168.1.254"
  }

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file("${path.module}/ssh/id_terraform")
    host        = "192.168.1.251"
    timeout     = "2m"
    agent       = false
  }

  provisioner "remote-exec" {
    inline = [
      local.install_cmd
    ]
  }
}
