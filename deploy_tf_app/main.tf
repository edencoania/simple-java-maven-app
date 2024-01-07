terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-1"
}


resource "aws_security_group" "allow_tls4" {
  name        = "allow_tls4"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks = ["0.0.0.0/0"]

}

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls4"
  }
}

variable "Name" {
  type    = string
  default = "eden_instance"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ce2cb35386fc22e9"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.allow_tls4.id]  # Reference the correct security group

  tags = {
        Name = var.Name
	}
  key_name = "weather"  # Specify the name of your key pair
 
  provisioner "local-exec" {
  command = "sleep 60 && ansible-playbook -i ${self.public_ip}, --key-file 'weather.pem' -u {var.user}, ./ansible/playbook2.yaml -b"  
# Assuming your Ansible playbook is in a folder called 'ansible'
# within your Terraform module.
  }
}

