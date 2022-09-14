resource "local_file" "pollo" {
    filename = "./pollo.txt"
    content = data.local_file.avestruz.content
}

data "local_file" "avestruz" {
    filename = "./avestruz.txt"
}