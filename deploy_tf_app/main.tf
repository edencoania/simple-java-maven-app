terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  
    ansible = {
      version = "~> 1.1.0"
      source  = "ansible/ansible"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-1"
}


variable "Name" {
  type    = string
  default = "eden_instance"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ce2cb35386fc22e9"
  instance_type = "t2.micro"

  vpc_security_group_ids = ["sg-079dae015ff397c06"]  # Reference the correct security group

  tags = {
        Name = var.Name
	}
  key_name = "weather" 
 
  #provisioner "ansible-local" {
  #playbook_file   = "./ansible/playbook2.yml"
  #extra_vars = {
  #  key = "weather.pem"
  #}
  #}
  provisioner "file" {
    source      = "./ansible/weather/app.py"
    destination = "/home/ubuntu/app.py" 
    
    connection {
      type        = "ssh"
      user        = "ubuntu"  
      private_key = file("weather.pem") 
      host        = aws_instance.app_server.public_ip  
    } 
  }
    user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install docker.io -y
    sudo systemctl enable docker
    sudo apt install python3 -y
    sudo apt install pip -y
    pip install flask
    
    sudo docker pull edencoania/release:hello_actions-latest
    python3 app.py
    EOF
}

