provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "my_keypair" {
  key_name   = "my_keypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+vkIb4nKNootwjuSQyS8YJOZ79JVXtJ9dAosQehwtyJcMH2UNoYMspdLHTJ0YhyVccLSJFgbe8BGaS/AEV5/S3Nh7t+86iYzhkTv/XNs8O/ycekVX9XNfUwXnezd0LUJutFwZdVDPm4xHgT9aUFsQYC+9xkFK18mZGyQ1nxs9vACTxQ6OXlKopC2WRhtQdRS35gesfNI1oiyBDNplkTNi8oHGA8J05E4SrJGv5HxASHL0oIec3SLbQbeghfEWvNcfQ3ir7jwIZE8BFDV3Gm1t0Z/CzEQuTXY8doeF0XTuvTbaZfRrqW2mYII+bXpGZgu/VbNlevm4eb/D2pDd+GZGxzX/d2VWNlWq0gLAcZYAwn0/TkrtR0V/swRJLOwCdfMP1we2KwM82B1EfyVDa4ThuYHfR7PEdNCtKZAIygyY0yZXeK+jpkhKx4i8TsmI2cGNd6JIzGGza/y1Tjdn6wooQ5ZC8hmgZB7pRuVmXIMg7W6zNhRS3+a7fjXTUmSDtZs= fabio@fabionote1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my_vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "my_subnet"
  }
}

resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow_ssh"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_keypair.key_name
  subnet_id     = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "my_instance"
  }
}

output "public_ip" {
  value = aws_instance.my_instance.public_ip
resource "aws_instance" "my_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_keypair.key_name
  subnet_id     = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "my_instance"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = aws_instance.my_instance.public_ip
    }
  }
}
