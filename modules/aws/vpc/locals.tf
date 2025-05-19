locals {
  subnet_ids = {
    for subnet_name, subnet in aws_subnet.this : subnet_name => subnet.id
  }
}
