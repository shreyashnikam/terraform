resource "aws_db_option_group" "this" {
  for_each = {
    for instance_key, instance_config in var.db_instances : instance_key => instance_config
    if local.create_db_option_group[instance_key]
  }

  name                  = local.db_identifier[each.key]
  engine_name           = each.value.db_engine
  major_engine_version  = each.value.db_major_engine_version

  dynamic "option" {
    for_each = each.value.db_option_group_options
    content {
      option_name                    = option.value.option_name
      port                           = lookup(option.value, "port", null)
      vpc_security_group_memberships = lookup(option.value, "vpc_security_group_memberships", null)
    }
  }

  tags = each.value.tags
}
