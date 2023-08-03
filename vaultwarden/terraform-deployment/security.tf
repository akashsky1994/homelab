# if using keys already on AWS
# data "aws_key_pair" "vw_ssh_key" {
#   key_name           = "vaultwarden"
#   include_public_key = true
# }

# Key setup and distribution
resource "tls_private_key" "vw_ssh_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "local_file" "vw_pvt_key" {
  content = tls_private_key.vw_ssh_key.private_key_pem
  filename = "vw_ssh_key"
  file_permission = 0400
}

resource "aws_key_pair" "vw_ssh_key" {
  key_name = "vw_ssh_key"
  public_key = tls_private_key.vw_ssh_key.public_key_openssh
}

resource "aws_security_group" "allow_https_ssh" {
  name = "allow_https_ssh"
  description = "Alow Inbound traffic"
  ingress {
    description = "http"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "vaultwarden"
  }
}