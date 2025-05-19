#Target Groups
resource "aws_lb_target_group" "this" {
  for_each = var.target_groups

  name                    = each.value.name
  port                    = each.value.port
  protocol                = each.value.protocol
  protocol_version        = each.value.protocol_version
  deregistration_delay    = each.value.deregistration_delay
  slow_start              = each.value.slow_start
  target_type             = each.value.target_type
  vpc_id                  = var.vpc_id

  health_check {
    enabled             = each.value.health_check.enabled
    healthy_threshold   = each.value.health_check.healthy_threshold
    interval            = each.value.health_check.interval
    matcher             = each.value.health_check.matcher
    path                = each.value.health_check.path
    port                = each.value.health_check.port
    protocol            = each.value.health_check.protocol
    timeout             = each.value.health_check.timeout
    unhealthy_threshold = each.value.health_check.unhealthy_threshold
  }

  stickiness {
    enabled         = each.value.stickiness.enabled
    type            = each.value.stickiness.type
    cookie_duration = each.value.stickiness.cookie_duration
  }

  tags = each.value.tags
}