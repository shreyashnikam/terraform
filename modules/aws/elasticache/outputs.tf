output "elasticache_replication_group_ids" {
  value = {
    for k, v in aws_elasticache_replication_group.this :
    k => v.id
  }
}
