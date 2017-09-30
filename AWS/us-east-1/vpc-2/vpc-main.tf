provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

module "vpc_network" {
  source = ".../.../rancher/terraform-modules/tree/master/modules/aws/network/networks/full-vpc"

  vpc_name             = "${var.aws_env_name}"
  vpc_cidr             = "${var.aws_vpc_cidr}"
  region               = "${var.aws_region}"
  public_subnet_cidrs  = "${var.aws_public_subnet_cidrs}"
  private_subnet_cidrs = "${var.aws_private_subnet_cidrs}"
  azs                  = "${var.aws_subnet_azs}"
}

  lifecycle {
    create_before_destroy = true
}
