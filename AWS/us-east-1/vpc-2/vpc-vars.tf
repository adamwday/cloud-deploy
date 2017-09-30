variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_env_name" {}

variable "aws_vpc_cidr" {}

variable "aws_region" {
default = "us-east-1"
}

variable "aws_subnet_azs" {}

variable "aws_public_subnet_cidrs" {}

variable "aws_private_subnet_cidrs" {}
