resource "aws_db_instance" "this" {
  for_each = var.db_instances

  allocated_storage    = each.value.db_allocated_storage
  engine               = each.value.db_engine
  engine_version       = each.value.db_engine_version
  instance_class       = each.value.db_instance_class
  identifier           = local.db_identifier[each.key]
  username             = each.value.db_username
  password             = each.value.db_password

  # Conditional subnet group name per instance
  db_subnet_group_name = local.create_db_subnet_group[each.key] ? aws_db_subnet_group.this[each.key].name : each.value.db_subnet_group_name

  # Conditional parameter group name per instance
  parameter_group_name = local.create_db_parameter_group[each.key] ? aws_db_parameter_group.this[each.key].name : each.value.db_parameter_group_name

  # Conditional option group name per instance
  option_group_name = local.create_db_option_group[each.key] ? aws_db_option_group.this[each.key].name : each.value.db_option_group_name

  vpc_security_group_ids = [for key in each.value.security_group_keys : local.security_group_ids_map[key]]

  skip_final_snapshot = true

  tags = each.value.tags
}

