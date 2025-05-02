output "root_path" {
  value = path.root
}

output "cwd_path" {
  value = path.cwd
}

output "cleaned" {
  value = trimspace("\n   hello world   \n")
  # => "hello world"
}

output "chomped_n" {
  value = "line\n"
  # => "line"
}

output "chomped" {
  value = chomp("line\n")
  # => "line"
}
