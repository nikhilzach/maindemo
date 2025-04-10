provider "aws" {
  region = "ap-south-1" 
}


resource "aws_security_group" "allow_all" {
  name_prefix = "allow_all_"
  
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "jenkins_master" {
  ami           = "ami-0e35ddab05955cf57" 
  instance_type = "t2.micro"
  key_name      = "Demokey"  
  security_groups = [aws_security_group.allow_all.name] 
  tags = {
    Name = "Jenkins Master"
  }
}


resource "aws_instance" "build_node" {
  ami           = "ami-0e35ddab05955cf57"  
  instance_type = "t2.micro"
  key_name      = "Demokey"  
  security_groups = [aws_security_group.allow_all.name] 
  tags = {
    Name = "Jenkins Build Node"
  }
}


resource "aws_instance" "ansible_server" {
  ami           = "ami-0e35ddab05955cf57"  
  instance_type = "t2.micro"
  key_name      = "Demokey"  
  security_groups = [aws_security_group.allow_all.name]  
  tags = {
    Name = "Ansible Server"
  }
}
