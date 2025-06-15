resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = var.datastore_iso
  node_name    = var.node_name
  url                  = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
  overwrite_unmanaged  = true
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = var.datastore_iso
  node_name    = var.node_name

  source_raw {
    data = <<-EOF
    #cloud-config
    chpasswd:
      list: |
        ubuntu:ubuntu
      expire: false
    hostname: ubuntu-hostname
    packages:
      - qemu-guest-agent
    users:
      - default
      - name: ubuntu
        groups: sudo
        shell: /bin/bash
        ssh-authorized-keys:
          - ${trimspace(file("./ssh/id_terraform.pub"))}
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
      - [systemctl, enable, --now, qemu-guest-agent]
    EOF

    file_name = "cloud-config.yaml"
  }
}


resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name            = "tf-ubuntu-cloud"
  node_name       = var.node_name
  stop_on_destroy = true

  disk {
    datastore_id = var.datastore_vm
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  initialization {
    datastore_id = var.datastore_vm
    user_account {
      username = "ubuntu"
      password = "ubuntu"
      keys     = [trimspace(file("./ssh/id_terraform.pub"))]
    }

    dns {
      servers = ["8.8.8.8", "1.1.1.1"]
    }

    ip_config {
      ipv4 {
        address = "192.168.1.101/24"
        gateway = "192.168.1.254"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
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
