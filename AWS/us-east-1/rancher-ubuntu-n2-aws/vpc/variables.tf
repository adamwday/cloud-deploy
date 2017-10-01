#------------------------------------------#
# AWS Environment Variables
#------------------------------------------#
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-1"
}
variable "region" {
    default     = "us-east-1"
    description = "The region of AWS, for AMI lookups"
}

variable "vpc_cidr" {
    default     = "192.168.199.0/24"
    description = "Subnet in CIDR format to assign to VPC"
}

variable "subnet_cidrs" {
    default     = ["192.168.199.0/26", "192.168.199.64/26", "192.168.199.128/26"]
    description = "Subnet ranges (requires 3 entries)"
}

variable "availability_zones" {
    default     = ["us-east-1a", "us-east-1b", "us-east-1d"]
    description = "Availability zones to place subnets"
}

variable "internal_elb" {
    default     = "false"
    description = "Force the ELB to be internal only"
}

variable "name_prefix" {
    default     = "rancher-ha"
    description = "Prefix for all AWS resource names"
}
