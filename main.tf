#Providers
provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region = var.region 
}

#Data
data "aws_ami" "aws_linux" {
    most_recent = true
    owners = ["amazon"]
  
  filter {
    name = "name"
    values =["amzn-ami-hvm*"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]  
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

#resources
#Default vpc

resource "aws_default_vpc" "default" {
  
}

resource "aws_security_group" "allow_ssh_http_80" {
    name = "allow_ssh_http"
    description = "allow ssh on 22 & http on 80"
    vpc_id = aws_default_vpc.default.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

     egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
  
  
}

resource "aws_instance" "nginx" {
    ami             = data.aws_ami.aws_linux.id 
    instance_type   = "t2.micro" 
    key_name        = var.key_name
    vpc_security_group_ids = [aws_security_group.allow_ssh_http_80.id] 

    tags = {
      Name = var.instance_name
    }

    connection { 
      type   = "ssh"
      host  = self.public_ip
      user   ="ec2-user"
      private_key = file(var.private_key_path)
    }

    provisioner "remote-exec" {
        inline = [
          "sudo yum install nginx -y",
          "sudo service nginx start"
        ]  
    }
}

#output
output "aws_instance_public_dns" {
    value = aws_instance.nginx.public_dns
  
}