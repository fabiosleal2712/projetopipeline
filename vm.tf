resource "aws_instance" "example" {
  ami           = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  key_name      = "keyterraforn"
  public_key    = file("./keyterraforn.pub")
}
