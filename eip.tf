resource "aws_eip" "eip1" {
  vpc           = true
  depends_on    = ["aws_internet_gateway.gw"] 
}
