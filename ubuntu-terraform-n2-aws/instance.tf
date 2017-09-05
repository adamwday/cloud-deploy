# Instance file used to change the AMI id into a lookup into a map variable
# which is stored in the vars.tf file.

resource "aws_key_pair" "mykeyubu" {
  key_name = "mykeyubu"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "example" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykeyubu.key_name}"

# Uploads this script to /tmp/
  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }
# Executes the script
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo bash /tmp/script.sh"
    ]
  }
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}
