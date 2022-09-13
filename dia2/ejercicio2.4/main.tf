resource "aws_iam_user" "admin-user" {
	name = ""
	tags = {
		Description = ""
	}
}


## Ejercicio 2.4.1, expandir variables en el resource block y correr init, plan, apply
## Terraform import no funciona... arreglemoslo.
variable "student_role" {
    default = ""
}

variable "student_name" {
    default = ""
}

