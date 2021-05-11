resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.public_subnet1}"
  map_public_ip_on_launch = true
  availability_zone = "${var.public_subnet_zone}"
  tags = {
  	Name =  "${var.name}"
    Tier = "Public"
  }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = "${aws_vpc.vpc.id}"

    tags {
        Name = "${var.name}"
    }
}

resource "aws_route" "public_route" {
	route_table_id  = "${aws_route_table.public_route_table.id}"
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = "${aws_internet_gateway.gw.id}"
}

resource "aws_route_table_association" "public_subnet_1_association" {
    subnet_id = "${aws_subnet.public_subnet_1.id}"
    route_table_id = "${aws_route_table.public_route_table.id}"
}
