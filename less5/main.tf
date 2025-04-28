module "db" {
  source = "./modules/db"
  db_ip  = "192.168.1.251/24"
}

module "app" {
  source  = "./modules/app"
  db_host = module.db.db_ip
}
