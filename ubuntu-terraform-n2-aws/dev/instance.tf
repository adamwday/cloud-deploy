/*
***************************************************************************
The instance is file used to:
1. Change the AMI id into a lookup into a map
   variable which is stored in the vars.tf file.
2. Lookup the VPC subnets and security groups so that we can deploy into
   said VPC.
3. Copy a script locally and run.
4. Lookup AWS user and private key
***************************************************************************
*/

/*
**************************************
The key pair to use for this instance.
**************************************
*/
resource "aws_key_pair" "mykeyubu" {
  key_name = "mykeyubu"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

/*
***************************************************************
Looking up the instance id, region, subnet, and security group.
***************************************************************
*/
resource "aws_instance" "example" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  subnet_id = "$(aws_subnet.main-public-1.id}"
  vpc_security_group_ids = ["$aws_security_group.sg-e32a8f8b.id}"]
  key_name = "${aws_key_pair.mykeyubu.key_name}"

/*
**************************************
Uploads this script to /tmp/.
**************************************
*/
  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }
/*
********************
Executes the script.
********************
*/
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo bash /tmp/script.sh"
    ]
  }
/*
***********************************************
Instance username and private key are resolved.
***********************************************
*/
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}
