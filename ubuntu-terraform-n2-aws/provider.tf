/*
***************************************************************************
Used to store the cloud provider alias, access key and secret key variables
as well as the region variable.
***************************************************************************
*/

provider "aws" {
access_key = "${var.AWS_ACCESS_KEY}"
secret_key = "${var.AWS_SECRET_KEY}"
    region = "${var.AWS_REGION}"
}
