cat terraform.tfstate | jq '.resources[] | select(.type == "aws_iam_access_key") | .instances[0].attributes'
