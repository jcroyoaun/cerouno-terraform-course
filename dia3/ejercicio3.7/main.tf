resource "aws_iam_user" "admin-user" {
    name = "cerounoStudent"
    tags = {
        Description = "Administrator"
    }
}

resource "aws_iam_policy" "adminUser" {
    name = "AdminUsers"
    policy = file("policy.json")
}

resource "aws_iam_user_policy_attachment" "cerouno-admin-access" {
  user = aws_iam_user.admin-user.name
  policy_arn = aws_iam_policy.adminUser.arn
}
