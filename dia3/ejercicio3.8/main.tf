resource "aws_s3_bucket" "catalogo" {
  bucket = "catalogo-14092022"

  tags = {
    Description = "Equipo de Merchandising"
  }
}

resource "aws_iam_group" "content-analyst" {
  name = "content-analyst"
}

resource "aws_iam_user" "catalog-user" {
    name = "CatalogUser"
    tags = {
        Description = "Catalogo"
    }
}

resource "aws_iam_user_group_membership" "add-user-to-group" {
  user = aws_iam_user.catalog-user.name

  groups = [
    aws_iam_group.content-analyst.name,
  ]
}

resource "aws_s3_object" "catalogo-2022" {
  content = "./catalogo-2022.csv"
  key     = "catalogo-2022"
  bucket  = aws_s3_bucket.catalogo.id
}

data "aws_iam_user" "catalog-data" {
    user_name = aws_iam_user.catalog-user.name
}

data "aws_iam_group" "content-data" {
  group_name = "content-analyst"
  depends_on = [
    aws_iam_group.content-analyst
  ]
}

output "arn_value" {
    value = data.aws_iam_group.content-data.arn
}

resource "aws_s3_bucket_policy" "merchandising-policy" {
  bucket = aws_s3_bucket.catalogo.id
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [{
		"Action": "*",
		"Effect": "Allow",
		"Resource": "arn:aws:s3:::${aws_s3_bucket.catalogo.id}/*",
		"Principal": {
			"AWS": [
                "${data.aws_iam_user.catalog-data.arn}"
            ]
		}
	}]
}
  EOF
}

output "fds" {
    value = data.aws_iam_user.catalog-data.user_name
}
# resource "aws_s3_object" "examplebucket_object" {
#   key    = "somekey"
#   bucket = aws_s3_bucket.catalogo.id
# }