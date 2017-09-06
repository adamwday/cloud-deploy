module "consul" {
  source = "https://github.com/adamwday/consul-terraform-module.git"
  key_name = "${aws_key_pair.mykeyubu.key_name}"
  key_path = "${var.PATH_TO_PRIVATE_KEY}"
  region = "${var.AWS_REGION}"
}
output "consul-output" {
  value = "${module.consul.server_address}"
}
