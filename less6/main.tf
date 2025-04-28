module "monitoring" {
  count  = var.enable_monitoring ? 1 : 0
  source = "./modules/monitoring"
  prometheus_ip = "192.168.1.253/24"
}

# or
#locals {
#  modules_enabled = var.enable_monitoring ? toset(["monitoring"]) : []
#}
#
#module "monitoring" {
#  for_each = local.modules_enabled
#  source   = "./modules/monitoring"
#
#  prometheus_ip = "192.168.22.99/24"
#}

module "db" {
  source = "./modules/db"
  db_ip  = "192.168.1.251/24"
}

module "app" {
  source  = "./modules/app"
  db_host = module.db.db_ip
}
