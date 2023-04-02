provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "vpc_pcbd" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc_pcbd"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.vpc_pcbd.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.vpc_pcbd.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "public_subnet_2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id     = aws_vpc.vpc_pcbd.id
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "public_subnet_3"
  }
}

resource "aws_security_group" "instance_sg" {
  name_prefix = "instance_sg_"
  vpc_id      = aws_vpc.vpc_pcbd.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "key_pair" {
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "ec2_instance" {
  ami           = "ami-0557a15b87f6559cf"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key_pair.key_name
  subnet_id     = "${aws_subnet.public_subnet_1.id}"
  vpc_security_group_ids = [
    "${aws_security_group.instance_sg.id}",
    ]
  
  tags = {
    Name = "pc"
  }
}
