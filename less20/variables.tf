variable "node_name" {
  description = "Имя ноды в кластере"
  type        = string
  default     = "pve"
}

variable "vm_count" {
  type = number
  default = 1
  
}

variable "datastore_iso" {
  description = "Datastore для ISO/образов"
  type        = string
  default     = "iso"
}

variable "datastore_vm" {
  description = "Datastore для VM-дисков"
  type        = string
  default     = "vm"
}

variable "ssh_key_path" {
  description = "Путь к публичному SSH-ключу"
  type        = string
  default     = "./ssh/id_terraform.pub"
}

variable "endpoint" {
  description = "URL Proxmox API"
  type        = string
}

variable "api_token" {
  description = "API-токен в формате ID=VALUE"
  type        = string
  sensitive   = true
}
