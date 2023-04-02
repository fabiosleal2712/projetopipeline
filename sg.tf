resource "aws_security_group" "sg1" {
  name        = "example"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vm1.id
  vpc_id      = aws_vpc.vm2.id
  

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}