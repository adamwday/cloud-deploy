resource "aws_key_pair" "mykeyubu" {
  key_name = "mykeyubu"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}
