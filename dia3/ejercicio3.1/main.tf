terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0885b1f6bd170450c"
  instance_type = "t2.micro"

  tags = {
    Name = "My Server"
  }
}


output "instance_ip_addr" {
  value       = aws_instance.app_server.private_ip
  description = "The private IP address of the main server instance."
}
