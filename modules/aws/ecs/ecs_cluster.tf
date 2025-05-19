resource "aws_ecs_cluster" "this" {
  for_each = var.ecs_clusters

  name = each.value.name

  tags = {
    Name        = each.value.name
    Environment = var.env
  }
}

resource "aws_ecs_capacity_provider" "ecs_asg_provider" {
  for_each = var.ecs_clusters

  name = "${each.value.name}-cp"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs_asg[each.key].arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      status                    = "ENABLED"
      target_capacity           = 100
      minimum_scaling_step_size = 1
      maximum_scaling_step_size = 1
    }
  }

  tags = var.tags
}

resource "aws_ecs_cluster_capacity_providers" "ecs" {
  for_each = var.ecs_clusters

  cluster_name       = aws_ecs_cluster.this[each.key].name
  capacity_providers = [aws_ecs_capacity_provider.ecs_asg_provider[each.key].name]
}