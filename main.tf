terraform{
    required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "5.69.0"
      }
    }
}

provider "aws" {
    region = "us-east-1"
}

# security group for allowed ports
resource "aws_security_group" "tech365-sg" {
    name = "tech365-sg"
    description = "Allow TLS inbound traffic"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = var.port
        to_port = var.port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# creating ec2 instance 
resource "aws_instance" "tech365-server" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    security_groups = [aws_security_group.tech365-sg.name]
    user_data = file("script.sh")

    tags = {
        Name = "tech365-server"
    }
}
