resource "local_file" "servers" {
    filename = var.filename[count.index]
    content = var.filename[count.index]
    count = 3
}
