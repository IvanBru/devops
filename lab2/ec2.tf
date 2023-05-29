variable "ami_value" {
    type = string
    # London 
    default = "ami-0aaa5410833273cfe" 
}

resource "aws_security_group" "server_sg" {
    name = "SG-${var.env}"
    vpc_id = aws_vpc.main_vpc.id

   ingress {
    description = "SSH from VPC"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Security-group-${var.env}"
  }

}

resource "aws_instance" "server_1"{
    ami = var.ami_value
    instance_type = "t2.micro"
    associate_public_ip_address = true
    subnet_id = aws_subnet.private_subnets[0].id
    key_name = "my-key"
    security_groups = [aws_security_group.server_sg.name]
    user_data = "${file("user_data1.sh")}"

}

resource "aws_instance" "server_2"{
    ami = var.ami_value
    instance_type = "t2.micro"
    associate_public_ip_address = true
    subnet_id = aws_subnet.private_subnets[1].id
    key_name = "my-key"
    security_groups = [aws_security_group.server_sg.name]
    user_data = "${file("user_data2.sh")}"

}

