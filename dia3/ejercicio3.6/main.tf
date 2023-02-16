resource "local_file" "server" {
  filename = each.value
  content = ""
  for_each = toset(var.filename)
}

# output "aves" {
#     value = local_file.server.filename
# }
