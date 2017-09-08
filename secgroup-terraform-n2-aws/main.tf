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
  resource "aws_security_group" "allow_ssh" {
  name = "allow_all"
  description = "Allow inbound SSH traffic from my IP"
  vpc_id = "vpc-61301008"

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
