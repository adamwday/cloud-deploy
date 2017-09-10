/*
********************************************************************
Gives you a friendly output of information after terraform apply has
been run on a given instance. (public IP, etc.)
********************************************************************
*/

output "your jenkins public ip" {
  value = "${aws_instance.jenkins.public_ip}"
}
output "your app1 public ip" {
  value = "${aws_instance.app1.public_ip}"
}
