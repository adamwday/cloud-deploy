/*
***************************************************************************
This file used to:
1. Change the AMI id into a lookup into a map
   variable which is stored in the vars.tf file.
2. Lookup the VPC subnets and security groups so that we can deploy into
   said VPC.
3. Copy a script locally and run.
4. Lookup AWS user and private key
**************************************************************************
*/

/*
*****************************************************
Lookup the public key and key name for this instance.
*****************************************************
*/

resource "aws_key_pair" "mykeyubu" {
  key_name = "mykeyubu"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

/*
**********************************************************************
Getting instance name, number of hosts, AMI-id, region, instance type,
VPC subnet, public key name, and user data for our persistent storage.
**********************************************************************
*/

resource "aws_instance" "example" {
  count = "1"
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.main-public-1.id}"
  key_name = "${aws_key_pair.mykeyubu.key_name}"
}

/*
*************************************************************
Creates a new EBS volume and attaches it to the EC2 instance.
*************************************************************
*/
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.example.id}"
  instance_id = "${aws_instance.example.id}"
}

resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-2a"
  size              = 10
}

/*
******************************************************************************
Adds constraints around blindly destroying machines until the new vm's are up.
Adds protection from accidental deletion if desired.
******************************************************************************
*/

#  lifecycle {
#      create_before_destroy = true
#      prevent_destroy = false
#  }
