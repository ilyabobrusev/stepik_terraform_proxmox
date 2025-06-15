variable "endpoint" {
  description = "URL Proxmox API"
  type        = string
}

variable "api_token" {
  description = "API-токен в формате ID=VALUE"
  type        = string
  sensitive   = true
}

variable "node_name" {
  description = "Имя ноды в кластере"
  type        = string
  default     = "pve"
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
