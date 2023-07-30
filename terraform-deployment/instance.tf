resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key"
  public_key = file(var.pvt_key)
}

resource "aws_instance" "vaultwarden_ec2" {
  ami           = var.aws_ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh_key.key_name

  tags = {
    Name = var.nametag
  }
  connection {
    host = self.public_ip
    user = "ubuntu"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
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

  # Copying environment variable files for vaultwarden sensitive
  provisioner "file" {
    source      = "./app_env/.env"
    destination = "/tmp/.env"
  }
}

resource "aws_eip" "vw_eip" {
  instance = aws_instance.vaultwarden_ec2.id
  vpc      = true
}

#Associate EIP with EC2 Instance
resource "aws_eip_association" "vw_eip_association" {
  instance_id   = aws_instance.vaultwarden_ec2.id
  allocation_id = aws_eip.vw_eip.id
}