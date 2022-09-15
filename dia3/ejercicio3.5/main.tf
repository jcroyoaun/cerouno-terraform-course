resource "local_file" "aves" {
    filename = var.filename[count.index]
    content = var.filename[count.index]
    count = 3
}