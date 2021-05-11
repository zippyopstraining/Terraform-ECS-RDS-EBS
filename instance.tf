resource "aws_instance" "bastion1" {
  ami                         = "${lookup(var.bastion_ami, var.region)}"
  instance_type               = "t2.micro"

  key_name                    = "${var.aws_key_name}"
  monitoring                  = true
  vpc_security_group_ids      = ["${aws_security_group.bastion.id}"]
  subnet_id                   = "${aws_subnet.public_subnet_1.id}"
  associate_public_ip_address = true

  tags {
    Name        = "${var.name}-bastion1"
    }
user_data = <<HEREDOC
  #!/bin/bash
  yum update -y
  yum install -y nginx
  service nginx start
HEREDOC

}
