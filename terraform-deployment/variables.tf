variable "access_key" {
    description = "Access Key"
    type = string
    sensitive = true
}

variable "secret_key" {
    description = "secret key"
    type = string
    sensitive = true
}

variable "region" {
    description = "AWS Region"
    type = string
    default = "us-east-1"
    sensitive = true
}

variable "public_ip" {}

variable "nametag" {
    type = string
    default = "VaultWarden CleverIdiot"
}

variable "aws_ami_id" {
    type = string
    description = "ami used for ec2 setup"
    default = "ami-053b0d53c279acc90"
}

variable "instance_type" {
    description = "instance type to be used for ec2 instance (e.g. t2 micro)"
    type = string
    default = "t2.micro"
}

variable "pvt_key" {
    description = "prviate ssh key path"
    type = string
    sensitive = true
}