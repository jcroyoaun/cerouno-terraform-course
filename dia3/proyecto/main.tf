#
# Lo que vamos a construir en este mini-proyecto es:
# un servidor EC2 que me permita hacerle SSH desde mi computadora local
# y que permita el trafico externo hacia el puerto 9090.
# esto para instalarle un prometheus al server y que podamos entrar desde fuera.
# paso 1. es crear la ec2 usando el resource block aws_instance con el ami apropiado. En este caso sera un t2.micro de us-east-1.
# paso 2. establecemos en el bloque provider la region deseada
# paso 3. crear una vpc no-default (y todos los elementos que se requieren).
#

resource "aws_vpc" "local-vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "my-gateway" {
  vpc_id = aws_vpc.local-vpc.id

  tags = {
    Name = "my-gateway"
  }
}

resource "aws_route_table" "my-route-table" {
  vpc_id = aws_vpc.local-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-gateway.id
  }
}

resource "aws_route_table_association" "my-assocation" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.my-route-table.id
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.local-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}

resource "aws_security_group" "allow_traffic" {
  name        = "allow_traffic"
  description = "Allows inbound SSH and HTTP traffic"
  vpc_id      = aws_vpc.local-vpc.id


  ingress {
    description = "SSH from my local using port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from my local using port 22"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from public internet using port 22"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "my-key-pair2" {
  key_name   = "my-key-pair2"
  public_key = file("<path to your id_rsa.pub>")
}

resource "aws_instance" "my-instance" {
  ami           = "ami-0885b1f6bd170450c"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.main.id
  key_name = aws_key_pair.my-key-pair2.key_name
  vpc_security_group_ids = [aws_security_group.allow_traffic.id]

  tags = {
    Name = "Prometheus Server"
  }

  associate_public_ip_address = true

    connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("<path to your private key from aws>")
    timeout     = "2m"
    host        = self.public_ip
  }
}

provider "aws" {
  region = "us-east-1"
}

output "public_ip" {
    value = aws_instance.my-instance.public_ip
}

resource "aws_eip" "my-eip" {
  instance = aws_instance.my-instance.id
}
