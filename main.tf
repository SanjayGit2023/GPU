terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
  }
}

provider "aws" {
  region = var.region_name
}

# STEP 1: CREATE SECURITY GROUP
resource "aws_security_group" "my-sg" {
  name        = "AI-SERVER-SG"
  description = "AI Server Ports"

  # Port 22 for SSH Access
  ingress {
    description = "SSH Port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 80 for HTTP
  ingress {
    description = "HTTP Port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Port 443 for HTTPS
  ingress {
    description = "HTTPS Port"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Additional custom ports
  ingress {
    description = "Custom Port 8001"
    from_port   = 8001
    to_port     = 8001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom Port 8050"
    from_port   = 8050
    to_port     = 8050
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom Port 8060"
    from_port   = 8060
    to_port     = 8060
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom Port 8070"
    from_port   = 8070
    to_port     = 8070
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule to allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# STEP 2: CREATE EC2 INSTANCE
resource "aws_instance" "my-ec2" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  vpc_security_group_ids = [aws_security_group.my-sg.id]

  root_block_device {
    volume_size = var.volume_size
  }

  tags = {
    Name = var.server_name
  }
}

# STEP 3: GET EC2 USER NAME AND PUBLIC IP 
output "SERVER-SSH-ACCESS" {
  value = "ubuntu@${aws_instance.my-ec2.public_ip}"
}

# STEP 4: GET EC2 PUBLIC IP 
output "PUBLIC-IP" {
  value = aws_instance.my-ec2.public_ip
}

# STEP 5: GET EC2 PRIVATE IP 
output "PRIVATE-IP" {
  value = aws_instance.my-ec2.private_ip
}
