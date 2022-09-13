resource "aws_iam_user" "admin-user" {
	name = var.student_name
	tags = {
		Description = var.student_role
	}
}

