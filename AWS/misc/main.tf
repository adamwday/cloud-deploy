#-----------------------------------------------------#
# Setting up our "test1" instance with startup script.
#-----------------------------------------------------#
resource "aws_instance" "test1" {
  ami                    = "${var.AWS_AMI}"
  instance_type          = "${var.AWS_INSTANCE_TYPE}"
  vpc_security_group_ids = ["${aws_security_group.websg.id}"]

  user_data = <<EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags {
    name    = "test1 tag"
    managed = "terraform"
  }
}

#-----------------------------------------------------#
# Configuring security group for the "test1" instance.
#-----------------------------------------------------#
resource "aws_security_group" "websg" {
  name = "web-security-group"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
