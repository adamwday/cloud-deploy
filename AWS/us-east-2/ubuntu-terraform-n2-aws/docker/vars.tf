/*
**************************************************************************
Declare the variables we want to use and supports lookup of the aws_region
from the instance.tf file.
**************************************************************************
*/
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-2"
  }

/*
*******************************************************
Allows lookup for the AMI ID from the instance.tf file.
*******************************************************
*/

  variable "AMIS" {
    type = "map"
    default = {
    us-east-2 = "ami-dbbd9dbe"
    }
  }

/*
**************************************************************************
Declared variables for private/public keys and instance username as called
by the instance.tf file.
**************************************************************************
*/

variable "DOCKER_HOST" {
  default = "13.58.219.28:2376/"
}
