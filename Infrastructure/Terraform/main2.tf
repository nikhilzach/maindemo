provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "k8s" {
  key_name   = "k8s-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "allow_all" {
  name        = "allow-all"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "master" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.medium"
  key_name      = aws_key_pair.k8s.key_name
  security_groups = [aws_security_group.allow_all.name]
  tags = { Name = "master" }
}

resource "aws_instance" "worker" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.medium"
  key_name      = aws_key_pair.k8s.key_name
  security_groups = [aws_security_group.allow_all.name]
  tags = { Name = "worker" }
}

output "master_ip" {
  value = aws_instance.master.public_ip
}

output "worker_ip" {
  value = aws_instance.worker.public_ip
}
