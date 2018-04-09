#-------------------------------------------------#
# Declaring the AWS_REGION.
#-------------------------------------------------#
variable "AWS_REGION" {
  description = "AWS region where deployed"
}

#----------------------------------------------------------------------#
# Declaring variables for the public/private paths for the RSA key pair.
#----------------------------------------------------------------------#
variable "PATH_TO_PRIVATE_KEY" {
  description = "Private key for our Ubuntu instances"
}

variable "PATH_TO_PUBLIC_KEY" {
  description = "Public key for our Ubuntu instances"
}

#---------------------------------------------------------------#
# Declaring variables for the AWS access key and secret key pair.
#---------------------------------------------------------------#
variable "SHARED_CREDS" {
  description = "Location of our AWS secrets"
}

#----------------------------------------#
# Declaring variables for the AWS AMI ID.
#----------------------------------------#
variable "AWS_AMI" {
  description = "AMI ID for our instance"
}

#-----------------------------------------------#
# Declaring variables for the AWS instance type.
#-----------------------------------------------#
variable "AWS_INSTANCE_TYPE" {
  description = "Type of instance (t2.micro, etc.)"
}
