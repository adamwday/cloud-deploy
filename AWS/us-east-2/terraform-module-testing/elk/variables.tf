#-------------------------------------------------#
# Specifying the default values for the AWS_REGION.
#-------------------------------------------------#
variable "AWS_REGION" {
  default = "us-east-2"
  description = "Test VPC"
}
#----------------------------------------------------------------------#
# Declaring variables for the public/private paths for the RSA key pair.
#----------------------------------------------------------------------#
variable "PATH_TO_PRIVATE_KEY" {
  default = "mykeyubu"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykeyubu.pub"
}
#---------------------------------------------------------------#
# Declaring variables for the AWS access key and secret key pair.
#---------------------------------------------------------------#
variable "AWS_ACCESS_KEY" {
}
variable "AWS_SECRET_KEY" {
}
#---------------------------------------------------------#
# Declaring variables/defaults for the Test VPC CIDR block.
#---------------------------------------------------------#
variable "vpc_cidr" {
    description = "VPC"
    default = "192.168.0.0/16"
}
#------------------------------------------------------------#
# Declaring variables/defaults for the Test VPC public subnet.
#------------------------------------------------------------#
variable "public_subnet_cidr" {
    description = "Public Subnet"
    default = "192.168.0.0/24"
}
#-------------------------------------------------------------#
# Declaring variables/defaults for the Test VPC private subnet.
#-------------------------------------------------------------#
variable "private_subnet_cidr" {
    description = "Private Subnet"
    default = "192.168.1.0/24"
}
#---------------------------------------------------------------#
# Declaring variables/defaults for the Test VPC EC2 NAT Instance.
#---------------------------------------------------------------#
variable "ami" {
}
variable "aws_key_path" {
}
variable "aws_key_name" {
}
