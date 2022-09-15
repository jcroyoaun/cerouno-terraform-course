resource "aws_iam_access_key" "admin-user" {
  user    = aws_iam_user.admin-user.name
  pgp_key = "keybase:test"
}

resource "aws_iam_user" "admin-user" {
  name = "new-user"
  path = "/system/"
}

resource "aws_iam_user_policy" "lb_ro" {
  name = "test"
  user = aws_iam_user.admin-user.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

output "secret" {
  value = aws_iam_access_key.admin-user.encrypted_secret
}

resource "aws_iam_user" "test" {
  name = "test"
  path = "/test/"
}