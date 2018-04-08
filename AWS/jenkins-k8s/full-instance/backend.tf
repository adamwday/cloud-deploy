/*
*****************************************
Stores the Terraform state file into S3.
*****************************************
*/

terraform {
  backend "s3" {
    bucket = "s3-tfstate-wd40"
    key    = "terraform/ubuntu-terraform-n2-aws"
    region = "us-east-2"
  }
}
