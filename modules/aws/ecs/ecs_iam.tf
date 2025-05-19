resource "aws_iam_role" "ecs_task_execution_role" {
  for_each = { for svc in var.services : svc.service_name => svc }

  name = "${var.env}-${each.value.service_name}-task-role"

  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role_policy.json
}

data "aws_iam_policy_document" "ecs_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  for_each = { for svc in var.services : svc.service_name => svc }

  role       = aws_iam_role.ecs_task_role[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "cloudwatch_logs" {
  for_each = { for svc in var.services : svc.service_name => svc }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:CreateLogGroup"
    ]

    resources = [
      "arn:aws:logs:${var.region_name}:${var.account_id}:log-group:/ecs/${var.env}-${each.key}:*"
    ]
  }
}

resource "aws_iam_policy" "cloudwatch_logs" {
  for_each = data.aws_iam_policy_document.cloudwatch_logs

  name   = "${var.env}-${each.key}-cw-logs"
  policy = each.value.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_cloudwatch_logs" {
  for_each = aws_iam_policy.cloudwatch_logs

  role       = aws_iam_role.ecs_task_role[each.key].name
  policy_arn = each.value.arn
}

resource "aws_iam_role" "ecs_task_role" {
  for_each = { for svc in var.services : svc.service_name => svc }

  name = "${var.env}-${each.value.service_name}-task-role"

  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role_policy.json
}

resource "aws_iam_policy" "custom_task_policy" {
  for_each = {
    for svc in var.services : svc.service_name => svc
    if length(lookup(svc, "custom_task_policies", [])) > 0
  }

  name   = "${var.env}-${each.key}-custom-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = each.value.custom_task_policies
  })
}

resource "aws_iam_role_policy_attachment" "custom_task_policy_attachment" {
  for_each = aws_iam_policy.custom_task_policy

  role       = aws_iam_role.ecs_task_role[each.key].name
  policy_arn = each.value.arn
}

