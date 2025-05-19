resource "aws_elasticache_replication_group" "this" {
  for_each = var.elasticache_clusters

  replication_group_id          = each.value.name
  description = "Valkey cluster for ${each.value.name}"
  engine                        = each.value.engine
  engine_version                = each.value.engine_version
  node_type                     = each.value.node_type
  port                          = each.value.port
  parameter_group_name          = each.value.parameter_group_name
  subnet_group_name             = aws_elasticache_subnet_group.this[each.key].name
  security_group_ids            = local.cluster_security_groups[each.key]
  maintenance_window            = each.value.maintenance_window
  snapshot_retention_limit      = each.value.snapshot_retention_limit
  snapshot_window               = each.value.snapshot_window
  at_rest_encryption_enabled    = each.value.at_rest_encryption_enabled
  transit_encryption_enabled    = each.value.transit_encryption_enabled
  apply_immediately             = each.value.apply_immediately

  automatic_failover_enabled    = each.value.cluster_mode_enabled
  num_node_groups               = each.value.cluster_mode_enabled ? each.value.num_node_groups : null
  replicas_per_node_group       = each.value.cluster_mode_enabled ? each.value.replicas_per_node_group : null

  tags = each.value.tags
}
