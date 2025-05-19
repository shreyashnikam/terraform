resource "aws_db_parameter_group" "this" {
  for_each = {
    for instance_key, instance_config in var.db_instances : instance_key => instance_config
    if local.create_db_parameter_group[instance_key]
  }

  name        = local.db_identifier[each.key]
  family      = each.value.db_family
  description = each.value.db_parameter_group_description

  dynamic "parameter" {
    for_each = each.value.db_parameter_group_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }

  tags = each.value.tags
}
