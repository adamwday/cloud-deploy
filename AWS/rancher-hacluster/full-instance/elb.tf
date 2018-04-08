#------------------------------------------#
# Elastic Load Balancer Configuration HTTPS
#------------------------------------------#
resource "aws_elb" "rancher_ha_https" {
    count    = "${var.enable_https}"
    name     = "${var.name_prefix}-elb-https"
    internal = "${var.internal_elb}"

    listener {
        instance_port      = 8080
        instance_protocol  = "tcp"
        lb_port            = 443
        lb_protocol        = "ssl"
        ssl_certificate_id = "${aws_iam_server_certificate.rancher_ha.arn}"
    }

    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        target              = "HTTP:8080/ping"
        interval            = 30
    }

    subnets         = ["${aws_subnet.rancher_ha.*.id}"]
    security_groups = ["${aws_security_group.rancher_ha_elb.id}"]
    instances       = ["${aws_instance.rancher_ha.*.id}"]

    idle_timeout                = 400
    cross_zone_load_balancing   = true
    connection_draining         = true
    connection_draining_timeout = 400

    tags {
        Name = "${var.name_prefix}-elb-https"
    }
}

resource "aws_iam_server_certificate" "rancher_ha" {
    count             = "${var.enable_https}"
    name              = "${var.name_prefix}-certificate"
    certificate_body  = "${file("${var.cert_body}")}"
    private_key       = "${file("${var.cert_private_key}")}"
    certificate_chain = "${file("${var.cert_chain}")}"
}

resource "aws_proxy_protocol_policy" "rancher_ha_https_proxy_policy" {
    count          = "${var.enable_https}"
    load_balancer  = "${aws_elb.rancher_ha_https.name}"
    instance_ports = ["81", "443", "8080"]
}

resource "aws_security_group_rule" "allow_https" {
    count             = "${var.enable_https}"
    type              = "ingress"
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.rancher_ha_elb.id}"
}

#------------------------------------------#
# Elastic Load Balancer Configuration HTTP
#------------------------------------------#
resource "aws_elb" "rancher_ha_http" {
    count    = "${1 - var.enable_https}"
    name     = "${var.name_prefix}-elb-http"
    internal = "${var.internal_elb}"

    listener {
        instance_port     = 8080
        instance_protocol = "tcp"
        lb_port           = 80
        lb_protocol       = "tcp"
    }

    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        target              = "HTTP:8080/ping"
        interval            = 30
    }

    subnets         = ["${aws_subnet.rancher_ha.*.id}"]
    security_groups = ["${aws_security_group.rancher_ha_elb.id}"]
    instances       = ["${aws_instance.rancher_ha.*.id}"]

    idle_timeout                = 400
    cross_zone_load_balancing   = true
    connection_draining         = true
    connection_draining_timeout = 400

    tags {
        Name = "${var.name_prefix}-elb-http"
    }
}

resource "aws_proxy_protocol_policy" "rancher_ha_http_proxy_policy" {
    count          = "${1 - var.enable_https}"
    load_balancer  = "${aws_elb.rancher_ha_http.name}"
    instance_ports = ["80", "81", "8080"]
}

resource "aws_security_group_rule" "allow_http" {
    count             = "${1 - var.enable_https}"
    type              = "ingress"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.rancher_ha_elb.id}"
}

#------------------------------------------#
# Elastic Load Balancer Common Configuration
#------------------------------------------#
resource "aws_security_group" "rancher_ha_elb" {
    name        = "${var.name_prefix}-elb-default"
    description = "Rancher HA ELB Common Traffic"
    vpc_id      = "${aws_vpc.rancher_ha.id}"
}

resource "aws_security_group_rule" "allow_all_self" {
    type              = "ingress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    self              = true
    security_group_id = "${aws_security_group.rancher_ha_elb.id}"
}

resource "aws_security_group_rule" "allow_icmp" {
    type              = "ingress"
    from_port         = 0
    to_port           = 0
    protocol          = "icmp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.rancher_ha_elb.id}"
}

resource "aws_security_group_rule" "allow_all_out" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.rancher_ha_elb.id}"
}
