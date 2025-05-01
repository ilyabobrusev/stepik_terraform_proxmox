locals {
  names = ["frontend", "backend", "db"]
  env   = "prod"
}

locals {
  full_names = [for name in local.names : format("%s-%s", name, local.env)]
}

output "joined_names" {
  value = join(", ", local.full_names)
}
