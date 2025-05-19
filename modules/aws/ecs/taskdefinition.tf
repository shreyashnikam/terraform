resource "aws_ecs_task_definition" "task_def" {
  for_each = { for svc in var.services : svc.service_name => svc }

  family                   = each.value.service_name
  network_mode             = "bridge"
  task_role_arn            = aws_iam_role.ecs_task_role[each.key].arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role[each.key].arn
  requires_compatibilities = ["EC2"]

  container_definitions = jsonencode([
    {
      name      = each.value.service_name
      image     = each.value.container_image
      cpu       = each.value.cpu
      memory    = each.value.memory
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 0
          protocol      = "tcp"
        }
      ]
      logConfiguration =  {
        logDriver = "awslogs"
          options = {
            awslogs-group         = "/ecs/${var.env}-${each.value.service_name}"
            awslogs-region        = var.region_name
            awslogs-stream-prefix = "ecs"
          }
      }
    }
  ])

  tags = var.tags
}