resource "aws_ecs_service" "ecs_service" {
  for_each = { for svc in var.services : svc.service_name => svc }

  name            = each.value.service_name
  cluster         = each.value.ecs_cluster_name
  task_definition = aws_ecs_task_definition.task_def[each.key].arn
  desired_count   = each.value.desired_count

  launch_type = "EC2"  # Using EC2 launch type
  health_check_grace_period_seconds = 60

  dynamic "load_balancer" {
    for_each = contains(keys(each.value), "target_group_name") ? [1] : []

    content {
      target_group_arn = var.target_group_arns[each.value.target_group_name]
      container_name   = each.value.container_name
      container_port   = each.value.container_port
    }
  }

  tags = var.tags
}