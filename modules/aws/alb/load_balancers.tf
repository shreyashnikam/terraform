resource "aws_lb" "this" {
  for_each = var.alb_details

  name               = each.value.name
  internal           = each.value.internal
  load_balancer_type = each.value.load_balancer_type
  subnets            = [for key in each.value.subnet_keys : var.subnet_id_map[key]]
  security_groups    = [for key in each.value.security_group_keys : local.security_group_ids_map[key]]
  tags               = each.value.tags
}
