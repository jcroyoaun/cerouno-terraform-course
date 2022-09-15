resource "local_file" "ave" {
  filename = each.value
  content = ""
  for_each = toset(var.filename)
}

# output "aves" {
#     value = local_file.ave.filename
# }