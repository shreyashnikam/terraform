output "ec2_aws_iam_role" {
  value = aws_iam_role.ecs_instance_role.arn
}

output "ecs_service_names" {
  description = "Names of all ECS services created"
  value = {
    for service, svc in aws_ecs_service.ecs_service :
    service => svc.name
  }
}

output "ecs_task_def_arns" {
  description = "ARNs of all ECS task definitions"
  value = {
    for task_def, td in aws_ecs_task_definition.task_def :
    task_def => td.arn
  }
}

output "cloudwatch_log_group_names" {
  value = [for lg in aws_cloudwatch_log_group.ecs : lg.name]
}
