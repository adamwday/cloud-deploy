#---------------------------------------------------#
# Storing the provider name and variables for region
# and the AWS access/secret key pair.
#---------------------------------------------------#
provider "aws" {
  region                  = "${var.AWS_REGION}"
  shared_credentials_file = "${var.shared_creds}"
}
