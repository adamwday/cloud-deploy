#---------------------------------------------------#
# Defining the VPC CIDR block, tag, and other values.
#---------------------------------------------------#
resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "us-east-2 VPC"
    }
}
resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}
#--------------------------------------------------#
# Defining the security group for the NAT instance.
#--------------------------------------------------#
resource "aws_security_group" "nat" {
    name = "NAT Instance"
    description = "Allows traffic to traverse the private subnet to the NAT instance"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr}"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr}"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    egress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"
    tags {
        Name = "NATSG"
    }
}
#--------------------------#
# Defining the NAT instance.
#--------------------------#
resource "aws_instance" "nat" {
    ami = "ami-021e3167" #Specific NAT Instance AMI ID
    availability_zone = "us-east-2a"
    instance_type = "t2.micro"
 #   key_name = ["${var.aws_key_name}"]
    vpc_security_group_ids = ["${aws_security_group.nat.id}"]
    subnet_id = "${aws_subnet.us-east-2a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false
    tags {
        Name = "VPC NAT"
    }
}
#---------------------------------------------#
# Defining the elastic IP for the NAT instance.
#---------------------------------------------#
resource "aws_eip" "nat" {
    instance = "${aws_instance.nat.id}"
    vpc = true
}
#---------------------------#
# Defining the public subnet.
#---------------------------#
resource "aws_subnet" "us-east-2a-public" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-east-2a"
    tags {
        Name = "Public Subnet"
    }
}
#-------------------------------------------------#
# Defining the routing table for the public subnet.
#-------------------------------------------------#
resource "aws_route_table" "us-east-2a-public" {
    vpc_id = "${aws_vpc.default.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }
    tags {
        Name = "Public Subnet"
    }
}
#--------------------------------------------------------------#
# Defining the routing table associations for the public subnet.
#--------------------------------------------------------------#
resource "aws_route_table_association" "us-east-2a-public" {
    subnet_id = "${aws_subnet.us-east-2a-public.id}"
    route_table_id = "${aws_route_table.us-east-2a-public.id}"
}
#----------------------------#
# Defining the private subnet.
#----------------------------#
resource "aws_subnet" "us-east-2a-private" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "us-east-2a"
    tags {
        Name = "Private Subnet"
    }
}
#--------------------------------------------------#
# Defining the routing table for the private subnet.
#--------------------------------------------------#
resource "aws_route_table" "us-east-2a-private" {
    vpc_id = "${aws_vpc.default.id}"
    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.nat.id}"
    }
    tags {
        Name = "Private Subnet"
    }
}
#---------------------------------------------------------------#
# Defining the routing table associations for the private subnet.
#---------------------------------------------------------------#
resource "aws_route_table_association" "us-east-2a-private" {
    subnet_id = "${aws_subnet.us-east-2a-private.id}"
    route_table_id = "${aws_route_table.us-east-2a-private.id}"
}