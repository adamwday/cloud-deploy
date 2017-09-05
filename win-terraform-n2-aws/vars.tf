variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-2"
}
variable "WIN_AMIS" {
  type = "map"
  default = {
    us-east-2 = "ami-14a68671"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykeywin"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykeywin.pub"
}
variable "INSTANCE_USERNAME" {
  default = "Terraform"
}
variable "INSTANCE_PASSWORD" { }
