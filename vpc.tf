resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc}"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.name}-VPC"
  }
}
