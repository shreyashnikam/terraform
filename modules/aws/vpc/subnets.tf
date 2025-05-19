resource "aws_subnet" "this" {
  for_each = var.subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 3, each.value.subnet_index)
  availability_zone = "${var.region}${each.value.az_suffix}"

  # Automatically enable public IP on launch if subnet type is public
  map_public_ip_on_launch = each.value.type == "public" ? true : false

  tags = {
    Name = each.key
    Type = each.value.type
    Environment = var.env
  }
}
