output "public_ip" {
    value = aws_instance.dev.public_ip
  
}

output "availability_zone" {
    value = aws_instance.dev.availability_zone
}

output "private_ip" {
    value = aws_instance.dev.private_ip
}