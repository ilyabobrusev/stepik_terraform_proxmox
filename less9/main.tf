locals {
  apps = ["api", "frontend", "worker"]
  zone = "ru-central"
}

locals {
  named_apps = [for name in local.apps : format("%s-%s", name, local.zone)]
}

output "app_names" {
  value = join(" | ", local.named_apps)
}

locals {
  nested = [["a"], ["b", "c"]]
  flat   = flatten(local.nested)
}

output "flat_result" {
  value = local.flat
}
