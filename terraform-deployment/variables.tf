
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
    default= "~/.ssh/id_rsa.pub"
}