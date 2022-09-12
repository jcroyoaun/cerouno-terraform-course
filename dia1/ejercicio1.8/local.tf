resource "local_file" "pollo" {
	filename = "./pollos.txt"
	content = "Me encantan los pollos!!"
	sensitive_content = "Me Encantan los pollos!!"
}
