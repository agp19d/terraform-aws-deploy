# EC2 instance to provision in us-east-1
resource "aws_instance" "ec2-instance1" {
  ami           = "ami-06b21ccaeff8cd686" # Amazon linux 3
  instance_type = "t2.micro"

  tags = {
    name = "demo-server1"
  }
}

# EC2 instance to provision in us-west-1
resource "aws_instance" "ec2-instance2" {
  provider      = aws.west
  ami           = "ami-0cf4e1fcfd8494d5b" # Amazon linux 3
  instance_type = "t2.micro"

  tags = {
    name = "demo-server2"
  }
}