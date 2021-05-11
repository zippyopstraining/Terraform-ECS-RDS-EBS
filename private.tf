resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.private_subnet1}"
  availability_zone       = "${var.private_subnet_zone1}"
  tags = {
  	Name =  "${var.name}"
        Tier = "Private"
     }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.private_subnet2}"
  availability_zone       = "${var.private_subnet_zone2}"
  tags = {
  	Name =  "${var.name}"
        Tier = "Private"
    }
}

resource "aws_route_table" "private_route_table1" {
    vpc_id = "${aws_vpc.vpc.id}"

    tags {
        Name = "{var.name}-Private route table1"
    }
}

resource "aws_route" "private_route1" {
	route_table_id  = "${aws_route_table.private_route_table1.id}"
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = "${aws_nat_gateway.nat1.id}"
}

resource "aws_route_table" "private_route_table2" {
    vpc_id = "${aws_vpc.vpc.id}"
    tags {
        Name = "${var.name}-Private route table2"
    }
}

resource "aws_route" "private_route2" {
        route_table_id  = "${aws_route_table.private_route_table2.id}"
        destination_cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat1.id}"
}



resource "aws_route_table_association" "private_subnet_1_association" {
    subnet_id = "${aws_subnet.private_subnet_1.id}"
    route_table_id = "${aws_route_table.private_route_table1.id}"
}


resource "aws_route_table_association" "private_subnet_2_association" {
    subnet_id = "${aws_subnet.private_subnet_2.id}"
    route_table_id = "${aws_route_table.private_route_table2.id}"
}
