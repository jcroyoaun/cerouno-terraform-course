resource "local_file" "pollo" {
    filename = "./pollo.txt"
    content = data.local_file.avestruz.filename
}

data "local_file" "avestruz" {
    filename = "./avestruz.txt"
}