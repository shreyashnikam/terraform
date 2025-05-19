output "db_instance_ids" {
  description = "Map of RDS instance IDs"
  value       = { for instance_key, instance in aws_db_instance.this : instance_key => instance.id }
}

output "db_instance_arns" {
  description = "Map of RDS instance ARNs"
  value       = { for instance_key, instance in aws_db_instance.this : instance_key => instance.arn }
}

output "db_instance_endpoints" {
  description = "Map of RDS instance endpoints"
  value       = { for instance_key, instance in aws_db_instance.this : instance_key => instance.endpoint }
}

output "db_instance_addresses" {
  description = "Map of RDS instance addresses"
  value       = { for instance_key, instance in aws_db_instance.this : instance_key => instance.address }
}

output "db_instance_ports" {
  description = "Map of RDS instance ports"
  value       = { for instance_key, instance in aws_db_instance.this : instance_key => instance.port }
}

output "db_instance_usernames" {
  description = "Map of RDS instance master usernames"
  value       = { for instance_key, instance in aws_db_instance.this : instance_key => instance.username }
}

output "db_subnet_group_names" {
  description = "Map of DB subnet group names (if created)"
  value = {
    for instance_key in keys(local.create_db_subnet_group) :
    instance_key => try(aws_db_subnet_group.this[instance_key].name, null)
    if local.create_db_subnet_group[instance_key]
  }
}

output "db_parameter_group_names" {
  description = "Map of DB parameter group names (if created)"
  value = {
    for instance_key in keys(local.create_db_parameter_group) :
    instance_key => try(aws_db_parameter_group.this[instance_key].name, null)
    if local.create_db_parameter_group[instance_key]
  }
}

output "db_option_group_names" {
  description = "Map of DB option group names (if created)"
  value = {
    for instance_key in keys(local.create_db_option_group) :
    instance_key => try(aws_db_option_group.this[instance_key].name, null)
    if local.create_db_option_group[instance_key]
  }
}
