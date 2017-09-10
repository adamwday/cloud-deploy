output "jenkins-ip" {
  value = "${aws_instance.jenkins.public_ip}"
}
output "app-ip" {
  value = "${aws_instance.app1.public_ip}"
}
