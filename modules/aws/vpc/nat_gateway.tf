resource "aws_eip" "nat_gw" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gw.id
  subnet_id     = local.subnet_ids["stage-public-subnet-1"]  # Reference the subnet ID from locals
  tags = {
    Name = "${var.env}-nat-gateway"
  }
}

