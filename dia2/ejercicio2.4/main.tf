resource "aws_iam_user" "user" {
  name = ""
  tags = {
    Description = ""
  }
}

variable "student_role" {
    default = ""
}

variable "student_name" {
    default = ""
}
