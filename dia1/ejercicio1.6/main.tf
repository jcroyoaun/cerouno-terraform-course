resource "local_file" "pollo" {
	filename = "./pollos.txt"
	content = "Me encantan los pollos!!"
       	# file_permission = "0700"
}
