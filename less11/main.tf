locals {
  base = { cpu = 1, mem = 512 }
  extra = { mem = 1024, disk = 20 }

  result = merge(local.base, local.extra)
}

output "merged" {
  value = local.result
}
