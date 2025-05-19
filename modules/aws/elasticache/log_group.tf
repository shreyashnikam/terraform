resource "aws_cloudwatch_log_group" "elasticache" {
  for_each           = { for k, v in var.elasticache_clusters : k => v if v.create_log_group }
  name               = "/aws/elasticache/${each.value.name}"
  retention_in_days  = each.value.log_group_retention_in_days
}
