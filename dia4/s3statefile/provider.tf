provider "aws" {
  region  = "us-east-1"
  profile = "default"
  default_tags {
    tags = {
      Organization = "cerouno"
      Environment  = "dia4"
    }
  }
}
