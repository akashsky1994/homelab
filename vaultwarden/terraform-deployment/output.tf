output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.vaultwarden_ec2.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.vaultwarden_ec2.public_ip
}

output "elastic_ip" {
  value = aws_eip.vw_eip.public_ip
}