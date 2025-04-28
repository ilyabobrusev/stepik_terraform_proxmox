variable "containers" {
  type = map(object({
    ip = string
  }))
  description = "Список контейнеров с именем и IP"
}

variable "bridge" {
  type        = string
  default     = "vmbr0"
  description = "Мост в Proxmox"
}

variable "ostemplate" {
  type        = string
  description = "Путь до шаблона LXC"
}

variable "storage" {
  type        = string
  description = "Имя хранилища для rootfs"
}

variable "size" {
  type        = string
  description = "Размер диска (например, 8G)"
}

variable "resources" {
  type = object({
    cores  = number
    memory = number
    swap   = number
  })
}

variable "ssh_public_key" {
  type        = string
  description = "Путь к публичному ключу"
}

variable "private_key" {
  type        = string
  description = "Приватный SSH-ключ для подключения"
}

variable "target_node" {
  type        = string
  description = "Узел Proxmox"
}

