variable "pm_api_url" {
  description = "API URL Proxmox"
}

variable "pm_token_id" {
  description = "ID токена Proxmox"
}

variable "pm_token_secret" {
  description = "Секрет токена Proxmox"
}

variable "pm_tls" {
  description = "Skip tls Proxmox"
  type        = bool
}

variable "containers" {
  type = map(object({
    ip     = string
    memory = number
    ssh    = string
  }))
  default = {
    app01 = {
      ip     = "192.168.1.101"
      memory = 1024
      ssh    = "" # Пустое значение, так как будем загружать ключи в main.tf
    },
    app02 = {
      ip     = "192.168.1.102"
      memory = 2048
      ssh    = "" # Пустое значение, так как будем загружать ключи в main.tf
    }
  }
}

variable "default_package" {
  type    = string
  default = "nginx"
}
