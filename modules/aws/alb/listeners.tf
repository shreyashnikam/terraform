resource "aws_lb_listener" "this" {
  for_each = var.listeners

  load_balancer_arn = local.alb_arn_map[each.value.alb_key]
  port              = each.value.port
  protocol          = each.value.protocol

  # Only define ssl_policy and certificate_arn for HTTPS listeners
  ssl_policy = each.value.protocol == "HTTPS" ? "ELBSecurityPolicy-2016-08" : null
  certificate_arn = each.value.protocol == "HTTPS" ? var.certificate_arn : null

  default_action {
    type             = "forward"
    target_group_arn = local.target_group_arn_map[each.value.target_group_key]
  }
}

