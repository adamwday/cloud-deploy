resource "aws_instance" "test1" {
  ami           = "ami40d28157"
  instance_type = "t2.micro"

  tags {
    Name = "test1 tag"
  }
}
