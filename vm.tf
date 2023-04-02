resource "aws_instance" "example" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  key_name      = "key_name"
  public_key    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+vkIb4nKNootwjuSQyS8YJOZ79JVXtJ9dAosQehwtyJcMH2UNoYMspdLHTJ0YhyVccLSJFgbe8BGaS/AEV5/S3Nh7t+86iYzhkTv/XNs8O/ycekVX9XNfUwXnezd0LUJutFwZdVDPm4xHgT9aUFsQYC+9xkFK18mZGyQ1nxs9vACTxQ6OXlKopC2WRhtQdRS35gesfNI1oiyBDNplkTNi8oHGA8J05E4SrJGv5HxASHL0oIec3SLbQbeghfEWvNcfQ3ir7jwIZE8BFDV3Gm1t0Z/CzEQuTXY8doeF0XTuvTbaZfRrqW2mYII+bXpGZgu/VbNlevm4eb/D2pDd+GZGxzX/d2VWNlWq0gLAcZYAwn0/TkrtR0V/swRJLOwCdfMP1we2KwM82B1EfyVDa4ThuYHfR7PEdNCtKZAIygyY0yZXeK+jpkhKx4i8TsmI2cGNd6JIzGGza/y1Tjdn6wooQ5ZC8hmgZB7pRuVmXIMg7W6zNhRS3+a7fjXTUmSDtZs= fabio@fabionote1"
}
