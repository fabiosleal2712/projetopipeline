resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.1.0/24"
}


resource "aws_subnet" "private_1" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.example.id
  tags = {
    Name = "private-subnet-1"
  }
}
resource "aws_db_subnet_group" "rds-mysql-subnet-group" {
  name       = "rds-mysql-subnet-group"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}
