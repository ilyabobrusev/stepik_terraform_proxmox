locals {
  raw_meta  = file("${path.module}/meta.txt")
  cleaned_0 = local.raw_meta
  cleaned_1 = chomp(local.raw_meta)
  cleaned_2 = trimspace(local.raw_meta)
}

output "without" {
  value = local.cleaned_0
}

output "with_chomp" {
  value = local.cleaned_1
}

output "with_trimspace" {
  value = local.cleaned_2
}

output "current_module_path" {
  value = path.module
}
