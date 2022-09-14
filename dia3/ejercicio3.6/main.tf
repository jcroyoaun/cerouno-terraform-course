resource "local_file" "ave" {
  filename = each.value
  for_each = toset(var.filename)
}

output "aves" {
    value = local_file.ave
}