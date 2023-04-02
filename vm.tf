resource "aws_key_pair" "mykey" {
  key_name   = "aws_key"
  public_key = var.aws_pub_key
}

resource "aws_instance" "example" {
  ami                         = "ami-007855ac798b5175e"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.mykey.key_name
  vpc_security_group_ids      = ["sg-01ceaee86002c8271"]
  subnet_id                   = "subnet-0a5dc38d5476fa9b5"
  associate_public_ip_address = true

  # ...
}
