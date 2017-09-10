output "your jenkins public ip" {
  value = "${aws_instance.jenkins.public_ip}"
}
output "your app1 public ip" {
  value = "${aws_instance.app1.public_ip}"
}
