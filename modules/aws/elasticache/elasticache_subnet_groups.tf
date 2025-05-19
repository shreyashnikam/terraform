resource "aws_elasticache_subnet_group" "this" {
  for_each = var.elasticache_clusters

  name        = "${each.value.name}-subnet-group"
  subnet_ids  = local.elasticache_subnet_ids[each.key]
  description = "Elasticache subnet group for ${each.value.name}"
}
