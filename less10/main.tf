variable "images" {
  default = {
    ru-central = "img-001"
    us-west    = "img-002"
  }
}

output "selected" {
  value = var.images["ru-central"]
}
