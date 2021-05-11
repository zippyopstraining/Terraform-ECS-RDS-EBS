resource "aws_db_subnet_group" "my_data_group" {
  name       = "my_data_group"
  subnet_ids = ["${aws_subnet.private_subnet_1.id}", "${aws_subnet.private_subnet_2.id}"]

  tags {
    Name = "${var.name}-db"
  }
}

resource "aws_db_instance" "mydb" {
  identifier           = "hashout"
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "${var.db_engine}"
  engine_version       = "${var.db_version}"
  instance_class       = "db.t2.micro"
  name                 = "${var.db_name}"
  username             = "${var.db_user}"
  password             = "${var.db_pass}"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = "${aws_db_subnet_group.my_data_group.id}"
  vpc_security_group_ids = ["${aws_security_group.private.id}"]
}
