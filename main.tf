provider "aws" {
  region = "us-east-1"  
}

resource "aws_default_vpc" "default" {
}

resource "aws_subnet" "default" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block ="172.31.32.0/20"  
}

resource "aws_security_group" "instance_sg" {
  name_prefix = "instance_sg_"
  vpc_id      = aws_default_vpc.default.id

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

resource "aws_instance" "example" {
  ami           = "ami-053b0d53c279acc90"  
  instance_type = "t2.micro"              
  subnet_id     = aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
}

                                                
