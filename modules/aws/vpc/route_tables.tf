resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public_rt_assoc_1" {
  subnet_id      = local.subnet_ids["stage-public-subnet-1"]  # Reference the subnet ID from locals
  route_table_id = aws_route_table.public_rt.id
}

# Repeat for public_rt_assoc_2 and _3

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
}

resource "aws_route_table_association" "private_rt_assoc_1" {
  subnet_id      = local.subnet_ids["stage-private-subnet-1"]  # Reference the subnet ID from locals
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rt_assoc_2" {
  subnet_id      = local.subnet_ids["stage-private-subnet-2"]  # Reference the subnet ID from locals
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rt_assoc_3" {
  subnet_id      = local.subnet_ids["stage-private-subnet-3"]  # Reference the subnet ID from locals
  route_table_id = aws_route_table.private_rt.id
}