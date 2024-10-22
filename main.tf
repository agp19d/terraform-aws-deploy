# main.tf 

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
    Environment = "dev"
  }
}

# Create a subnet
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "main-subnet"
    Environment = "dev"
  }
}

# Create a security group
resource "aws_security_group" "allow_ssh" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh"
    Environment = "dev"
  }
}

# Create an EC2 instance
resource "aws_spot_instance_request" "demo-spot-request" {
  count = 3 # Create 3 spot instances
  ami           = "ami-06b21ccaeff8cd686"
  instance_type = "t2.micro"
  spot_price      = "0.03"
  subnet_id     = aws_subnet.main.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "demo-server-${count.index + 1}"
    Environment = "dev"
  }
}
