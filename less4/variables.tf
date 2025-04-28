variable "vm_count" {
  description = "Сколько контейнеров создать"
  type        = number
  default     = 2
}

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
