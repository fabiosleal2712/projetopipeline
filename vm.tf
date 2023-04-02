resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("./keyterraforn.pub")
}

resource "aws_instance" "example" {
  ami                         = "ami-007855ac798b5175e"
  key_name                    = aws_key_pair.mykey.key_name
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["sg-01ceaee86002c8271"]
  subnet_id                   = "subnet-0a5dc38d5476fa9b5"
  associate_public_ip_address = true

  # ...
}
