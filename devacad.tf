# Configure the AWS Provider
provider "aws" {
  version = "~> 5.0"
  region  = "eu-west-1"
}

# Configure iam user
resource "aws_iam_user" "dev" {
  name = "devops"
  path = "/"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "henkserver" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "devteam"
 } 
}