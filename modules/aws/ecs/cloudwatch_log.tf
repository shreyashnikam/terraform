resource "aws_cloudwatch_log_group" "ecs" {
  for_each = { for svc in var.services : svc.service_name => svc }

  name              = "/ecs/${var.env}-${each.key}"
  retention_in_days = var.log_retention_in_days
}
