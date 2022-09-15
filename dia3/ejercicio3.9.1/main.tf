resource "aws_iam_user" "catalog-user" {
    name = "CatalogUser"
    tags = {
        Description = "Catalogo"
    }
}

resource "aws_iam_policy" "adminUser" {
    name = "AdminUsers2"
    policy = file("policy.json")
}

resource "aws_iam_user_policy_attachment" "cerouno-admin-access" {
  user = aws_iam_user.catalog-user.name
  policy_arn = aws_iam_policy.adminUser.arn
}