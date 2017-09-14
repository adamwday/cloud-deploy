resource "aws_security_group" "jenkins-securitygroup" {
  vpc_id = "${aws_vpc.main.id}"
  name = "jenkins-securitygroup"
  description = "security group that allows ssh and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags {
    Name = "jenkins-securitygroup"
  }
}

resource "aws_security_group" "app1-securitygroup" {
  vpc_id = "${aws_vpc.main.id}"
  name = "app1-securitygroup"
  description = "security group that allows ssh and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

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
 tags {
    Name = "app1-securitygroup"
   }
  }

 resource "aws_security_group" "allow_ssh" {
 name = "allow_all"
 description = "Allow inbound SSH traffic from my IP"
 vpc_id = "${aws_vpc.main.id}"

 ingress {
 from_port = 22
 to_port = 22
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
   }

 tags {
 Name = "Allow SSH"
   }
 }
