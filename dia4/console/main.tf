resource "local_file" "servers" {
    filename = var.nombres_de_servidores[count.index]
    content = var.nombres_de_servidores[count.index]
    count = 3
}
