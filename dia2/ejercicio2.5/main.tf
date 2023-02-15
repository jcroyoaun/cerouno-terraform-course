resource "aws_iam_user" "user" {
	name = var.student_name
	tags = {
		Description = var.student_role
	}
}
