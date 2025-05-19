resource "aws_db_subnet_group" "this" {
  for_each = {
    for instance_key, instance_config in var.db_instances : instance_key => instance_config
    if local.create_db_subnet_group[instance_key]
  }

  name        = "${each.value.db_instance_name}-subnet-group"
  subnet_ids  = local.db_subnet_ids[each.key]
  description = each.value.db_subnet_group_description
  tags        = each.value.tags
}
