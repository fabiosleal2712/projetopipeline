output "public_ip" {
  value = aws_instance.vm1.public_ip
}

output "public_ip1" {
  value = aws_instance.vm2.public_ip
}