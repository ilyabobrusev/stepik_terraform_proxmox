output "container_ips" {
  value = [for c in var.containers : c.ip]
}
