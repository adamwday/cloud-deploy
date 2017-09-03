# Instance file used to change the AMI id into a lookup into a map variable
# which is stored in the vars.tf file.

resource "aws_instance" "example instance" {
            ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
}
