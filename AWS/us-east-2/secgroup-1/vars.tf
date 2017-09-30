/*
********************************************************
Declares variables for looking up the aws access key,
secret key, and default region as referenced in main.tf.
This is done so that we do not publicly expose the keys.
********************************************************
*/
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-2"
  }
