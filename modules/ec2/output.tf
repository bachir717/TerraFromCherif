output "out_instance_id" {
  value = aws_instance.cherif-ec2.id
}

output "out_instance_az" {
  value = aws_instance.cherif-ec2.availability_zone
}
