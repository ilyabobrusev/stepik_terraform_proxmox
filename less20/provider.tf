terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.76.0"
    }
  }
}

# Remove endpoint, api_token and insecure if you use env variables
provider "proxmox" {
  endpoint  = var.endpoint
  api_token = var.api_token
  insecure  = true
  random_vm_ids = true
  ssh {
    agent    = true
    username = "root"
  }
}

