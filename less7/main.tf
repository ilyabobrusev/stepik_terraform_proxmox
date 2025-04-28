locals {
  apps = ["api", "frontend", "worker"]
  zone = "ru-central"
  nested = [["a"], ["b", "c"]]
  named_apps = [for name in local.apps : format("%s-%s", name, local.zone)]
  flat   = flatten(local.nested)
}

# locals {
#   named_apps = [for name in local.apps : format("%s-%s", name, local.zone)]
#   flat   = flatten(local.nested)
# }

output "app_names" {
  value = join(" | ", local.named_apps)
}

output "flat_result" {
  value = local.flat
}
