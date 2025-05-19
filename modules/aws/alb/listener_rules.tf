resource "aws_lb_listener_rule" "rules" {
  for_each     = var.listener_rules

  listener_arn = local.listener_arn_map[each.value.listener_key]
  priority     = each.value.priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this[each.value.actions[0].target_group_key].arn
  }

  dynamic "condition" {
    for_each = each.value.conditions
    content {
      dynamic "host_header" {
        for_each = try(condition.value.host_header, null) != null ? [condition.value.host_header] : []
        content {
          values = host_header.value
        }
      }

      dynamic "path_pattern" {
        for_each = try(condition.value.path_pattern, null) != null ? [condition.value.path_pattern] : []
        content {
          values = path_pattern.value
        }
      }
    }
  }


  # Add more condition types here if needed (e.g., http_header, http_request_method, source_ip, etc.)
}