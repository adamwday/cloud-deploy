resource "aws_instance" "test1" {
  ami           = "${var.AWS_AMI}"
  instance_type = "${var.AWS_INSTANCE_TYPE}"

  tags {
    Name    = "test1 tag"
    managed = "terraform"
  }
}
