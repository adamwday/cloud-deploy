/*
****************************************************
Looks up access key, secret key, and default region
from terraform.tfvars (in gitignore list).
****************************************************
*/
provider "aws" {
access_key = "${var.AWS_ACCESS_KEY}"
secret_key = "${var.AWS_SECRET_KEY}"
    region = "${var.AWS_REGION}"
}

/*
****************************************************
Creates security group & adds rules.
****************************************************
*/
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

resource "aws_security_group" "k8s-securitygroup" {
  vpc_id = "${aws_vpc.main.id}"
  name = "k8s-securitygroup"
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
    Name = "k8s-securitygroup"
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
