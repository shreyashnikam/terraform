output "vpc_id" {
  description = "VPC ID from the VPC module"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "VPC CIDR block from the VPC module"
  value       = module.vpc.vpc_cidr
}

output "subnet_ids" {
  description = "Subnet IDs from the VPC module"
  value       = module.vpc.subnet_ids
}

output "alb_arns" {
  description = "Map of ALB ARNs from the ALB module"
  value       = module.alb.alb_arn_map
}

output "target_group_arns" {
  description = "Map of Target Group ARNs from the ALB module"
  value       = module.alb.target_group_arns
}

output "security_group_ids" {
  description = "Map of security group IDs from the ALB module"
  value       = module.alb.security_group_ids
}

output "certificate_arn" {
  description = "ACM certificate ARN from the ALB module"
  value       = module.acm.certificate_arn
}

output "ecs_service_names" {
  description = "Map of ECS Cluster Services ARNs from the ECS module"
  value       = module.ecs.ecs_service_names
}

output "ecs_task_def_arns" {
  description = "Map of ECS Task Definition ARNs from the ECS module"
  value       = module.ecs.ecs_task_def_arns
}

output "ecs_instance_role_arn" {
  description = "ECS EC2 instance IAM role ARN from the IAM module"
  value       = module.ecs.ec2_aws_iam_role
}

output "rds_instance_id" {
  description = "The RDS instance ID"
  value       = module.rds.db_instance_ids
}

output "rds_instance_arn" {
  description = "ARN of the RDS instance"
  value       = module.rds.db_instance_arns
}

output "rds_endpoint" {
  description = "The connection endpoint of the RDS instance"
  value       = module.rds.db_instance_endpoints
}

output "rds_address" {
  description = "The address of the RDS instance"
  value       = module.rds.db_instance_addresses
}

output "rds_port" {
  description = "The port of the RDS instance"
  value       = module.rds.db_instance_ports
}

output "rds_username" {
  description = "The master username for the RDS instance"
  value       = module.rds.db_instance_usernames
}

output "rds_subnet_group_name" {
  description = "The DB subnet group name"
  value       = module.rds.db_subnet_group_names
}

output "rds_parameter_group_name" {
  description = "The DB parameter group name"
  value       = module.rds.db_parameter_group_names
}

output "rds_option_group_name" {
  description = "The DB option group name"
  value       = module.rds.db_option_group_names
}


