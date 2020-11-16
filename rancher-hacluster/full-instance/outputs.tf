#----------------------------------#
# AWS Outputs Post-Terraform Apply
#----------------------------------#
output "Elastic Load Balancer DNS (HTTP) =" {
    value = "${aws_elb.rancher_ha_http.dns_name}"
}

output "Elastic Load Balancer DNS (HTTPS) =" {
    value = "${aws_elb.rancher_ha_https.dns_name}"
}
