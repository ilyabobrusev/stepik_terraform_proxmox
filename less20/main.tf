locals {
  user_data = templatefile(
    "cloud-init-base.yaml",
    { ssh_key = trimspace(file(var.ssh_key_path)) }
  )
}

resource "proxmox_virtual_environment_file" "agent_snippet" {
  content_type = "snippets"
  datastore_id = var.datastore_iso
  node_name    = var.node_name

  source_raw {
    data      = local.user_data
    file_name = "cloud-init-base.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  count   = var.vm_count
  name            = "tf-ubuntu-${2001 + var.vm_count}"
  node_name       = var.node_name
  stop_on_destroy = true
  #vm_id = 2001 + var.vm_count

  disk {
    datastore_id = var.datastore_vm
    interface    = "virtio0"
    file_id      = "${var.datastore_iso}:iso/jammy-server-cloudimg-amd64.img"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  initialization {
    user_data_file_id = proxmox_virtual_environment_file.agent_snippet.id
    datastore_id = var.datastore_vm

    dns {
      servers = ["8.8.8.8", "1.1.1.1"]
    }

    ip_config {
      ipv4 {
        address = "192.168.1.101/24"
        gateway = "192.168.1.254"
      }
    }
  }
  cpu {
    sockets = 1
    cores   = 2
  }
  memory {
    dedicated = 1024
  }
  # Устанавливаем агент для динамического получения IP
  agent {
    enabled = true
  }
  network_device {
    bridge = "vmbr0"
  }
}