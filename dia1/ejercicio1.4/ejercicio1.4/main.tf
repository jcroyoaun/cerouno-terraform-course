# provider "aws" {
# 	region = "us-west-2"
# }

resource "aws_iam_user" "admin-user" {
	name = ""
	tags = {
		Description = "Alumno"
	}
}
