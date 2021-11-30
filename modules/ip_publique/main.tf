resource "aws_eip" "my_eip" {
  vpc      = true
  provisioner "local-exec" {
    command = "echo  PUBLIC IP: ${aws_eip.my_eip.public_ip} >> info.ec2.txt"
  }
}