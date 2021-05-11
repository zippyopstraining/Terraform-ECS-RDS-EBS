resource "aws_instance" "nginx1" {
  ami                         = "${lookup(var.bastion_ami, var.region)}"
  instance_type               = "t2.micro"
  key_name                    = "${var.aws_key_name}"
  monitoring                  = true
  vpc_security_group_ids      = ["${aws_security_group.private.id}"]
  subnet_id                   = "${aws_subnet.public_subnet_1.id}"
  associate_public_ip_address = true

  tags {
    Name        = "${var.name}-nginx-1"
    }
user_data = <<HEREDOC1
#!/bin/bash
yum update -y
yum install -y nginx
service nginx start
HEREDOC1
depends_on = ["aws_ecs_service.cntr1"]
}

resource "aws_instance" "nginx2" {
  ami                         = "${lookup(var.bastion_ami, var.region)}"
  instance_type               = "t2.micro"
  key_name                    = "${var.aws_key_name}"
  monitoring                  = true
  vpc_security_group_ids      = ["${aws_security_group.private.id}"]
  subnet_id                   = "${aws_subnet.private_subnet_2.id}"
  associate_public_ip_address = false

  tags {
    Name        = "${var.name}-nginx-2"
    }
user_data = <<HEREDOC2
#!/bin/bash
yum update -y
yum install -y nginx
service nginx start
HEREDOC2
depends_on = ["aws_ecs_service.cntr2"]
}
