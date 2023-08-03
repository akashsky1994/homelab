
resource "aws_instance" "vaultwarden_ec2" {
  ami           = var.aws_ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.vw_ssh_key.key_name #data.aws_key_pair.vw_ssh_key.key_name
  security_groups = [aws_security_group.allow_https_ssh.name]

  tags = {
    Name = "VaultWarden VM"
    Project = "VaultWarden by CI"
  }
  connection {
    host = self.public_ip
    user = "ubuntu"
    type = "ssh"
    private_key = tls_private_key.vw_ssh_key.private_key_pem #file("~/.ssh/vaultwarden.pem")
    timeout = "2m"
  }
  
  # Copying environment variable files for vaultwarden sensitive
  provisioner "file" {
    source      = "./app_env/.env"
    destination = "/tmp/.env"
  }
  provisioner "file" {
    source      = "./external_scripts/setup_project.sh"
    destination = "/tmp/setup_project.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "chmod +x /tmp/setup_project.sh",
      "/tmp/setup_project.sh",
    ]
  }
}

# Elastic IP generation and allocation
resource "aws_eip" "vw_eip" {
  instance = aws_instance.vaultwarden_ec2.id
  domain = "vpc"
}

#Associate EIP with EC2 Instance
resource "aws_eip_association" "vw_eip_association" {
  instance_id   = aws_instance.vaultwarden_ec2.id
  allocation_id = aws_eip.vw_eip.id
}
