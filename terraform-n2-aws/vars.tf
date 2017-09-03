# Used to declare the variables we want to use.

variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-2"
  }

# Supports lookup of the aws_region from the instance.tf file.
  variable "AMIS" {
    type = "map"
    default = {
    us-east-2 = "ami-dbbd9dbe"
    }
  }
