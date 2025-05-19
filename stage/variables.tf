# Network details..

variable "region" {
  description = "Region name"
  type        = string
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR of new VPC"
  type        = string
}

variable "subnets" {
  description = "Map of subnet configurations"
  type = map(object({
    az_suffix     = string       # e.g. "a", "b", "c"
    subnet_index  = number       # index for cidrsubnet
    type          = string       # "public" or "private"
  }))
}

variable "domain_name" {
  type        = string
  description = "FQDN for ACM cert and ALB (e.g. stage.pratilipi.com)"
}

variable "zone_name" {
  type        = string
  description = "Name of the hosted zone (e.g. stage.pratilipi.com)"
}

# Loadbalancer details..

variable "alb_details" {
  type = map(object({
    name                 = string
    internal             = bool
    load_balancer_type   = string
    subnet_keys          = list(string)
    security_group_keys  = list(string)
    tags                 = map(string)
  }))
}

variable "target_groups" {
  description = "Map of target group configurations"
  type = map(object({
    name                 = string
    port                 = number
    protocol             = string
    protocol_version     = string
    deregistration_delay = number
    slow_start           = number
    target_type          = string
    alb_name             = string
    tags                 = map(string)
    health_check = object({
      enabled             = bool
      healthy_threshold   = number
      interval            = number
      matcher             = string
      path                = string
      port                = string
      protocol            = string
      timeout             = number
      unhealthy_threshold = number
    })
    stickiness = object({
      enabled         = bool
      type            = string
      cookie_duration = number
    })
  }))
}

variable "listener_rules" {
  description = "Listener rules"
  type = map(object({
    listener_key = string
    priority     = number
    conditions   = list(object({
      path_pattern = optional(list(string))
      host_header  = optional(list(string))
    }))
    actions      = list(object({
      target_group_key = string
    }))
  }))
}

variable "security_groups" {
  description = "Map of security groups to create"
  type = map(object({
    name        = string
    description = string
    ingress     = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = optional(list(string), [])
      sg_ids      = optional(list(string), [])
    }))
    egress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = optional(list(string), [])
      sg_ids      = optional(list(string), [])
    }))
    tags = map(string)
  }))
}

variable "listeners" {
  type = map(object({
    alb_key          = string
    port             = number
    protocol         = string
    target_group_key = string
  }))
  description = "Map of listener definitions keyed by a name."
  default     = {}
}

# General Environment Settings
variable "env" {
  description = "The environment name (e.g., dev, stage, prod)"
  type        = string
}

# ECS Cluster Settings

variable "ec2_security_groups" {
  description = "Map of security groups to create"
  type = map(object({
    name        = string
    description = string
    ingress     = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = optional(list(string), [])
      sg_ids      = optional(list(string), [])
    }))
    egress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = optional(list(string), [])
      sg_ids      = optional(list(string), [])
    }))
    tags = map(string)
  }))
}

variable "ecs_clusters" {
  type = map(object({
    name                 = string
    subnet_keys          = list(string)
    security_group_keys  = list(string)
    tags                 = map(string)
  }))
}

variable "asg_max_size" {
  description = "Maximum size of the autoscaling group"
  type        = number
  default     = 2
}

variable "asg_min_size" {
  description = "Minimum size of the autoscaling group"
  type        = number
  default     = 1
}

variable "asg_desired_capacity" {
  description = "Desired capacity of the autoscaling group"
  type        = number
  default     = 1
}

variable "asg_instance_types" {
  description = "List of instance types to be used in ASG"
  type        = list(string)
  default     = ["t3.medium", "t3a.medium"]
}

variable "asg_on_demand_base_capacity" {
  description = "Base number of on-demand instances"
  type        = number
  default     = 1
}

variable "asg_on_demand_percentage_above_base_capacity" {
  description = "Percentage of on-demand instances above base capacity"
  type        = number
  default     = 50
}

variable "asg_spot_allocation_strategy" {
  description = "Spot allocation strategy for mixed instances"
  type        = string
  default     = "capacity-optimized"
}

variable "log_retention_in_days" {
  type    = number
  default = 7
}

variable "image_id" {
  description = "ECS optimized aws image id"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for ECS cluster"
  type        = string
  default     = "t3.medium"
}

# SSH Key
variable "public_key_path" {
  description = "Path to the local public SSH key"
  type        = string
}

# Tags
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

variable "services" {
  description = "List of ECS services and their configurations"
  type = list(object({
    service_name     = string
    service_role     = string
    ecs_cluster_name = string
    target_group_name    = string
    container_image  = string
    container_name   = string
    cpu              = number
    memory           = number
    desired_count    = number
    container_port   = number
    custom_task_policies  = optional(list(string), [])
  }))
}

#DB details

variable "db_security_groups" {
  description = "Map of security groups to create"
  type = map(object({
    name        = string
    description = string
    ingress     = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = optional(list(string), [])
      sg_ids      = optional(list(string), [])
    }))
    egress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = optional(list(string), [])
      sg_ids      = optional(list(string), [])
    }))
    tags = map(string)
  }))
}

variable "db_instances" {
  description = "Map of DB instances and their configurations"
  type = map(object({
    db_instance_name               = string
    db_use_name_prefix            = bool
    security_group_keys           = list(string)
    db_subnet_keys                = list(string)
    db_allocated_storage          = number
    db_engine                     = string
    db_engine_version             = string
    db_instance_class             = string
    db_username                   = string
    db_password                   = string
    db_name                       = string

    create_db_subnet_group        = bool
    db_subnet_group_name          = string
    db_subnet_group_description   = string

    create_db_parameter_group     = bool
    db_parameter_group_name       = string
    db_parameter_group_description = string
    db_parameter_group_parameters = list(object({
      name         = string
      value        = string
      apply_method = optional(string)
    }))

    create_db_option_group        = bool
    db_option_group_name          = string
    db_option_group_options       = list(object({
      option_name                   = string
      port                          = optional(number)
      vpc_security_group_memberships = optional(list(string))
    }))

    db_family                     = string
    db_major_engine_version       = string
    tags                          = map(string)
  }))
}

#Elasticache details
variable "elasticache_security_groups" {
  type = map(object({
    name        = string
    description = string
    ingress     = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = optional(list(string), [])
      sg_ids      = optional(list(string), [])
    }))
    egress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = optional(list(string), [])
      sg_ids      = optional(list(string), [])
    }))
    tags = map(string)
  }))
}

variable "elasticache_clusters" {
  type = map(object({
    name                                = string
    node_type                           = string
    engine                              = string
    engine_version                      = string
    parameter_group_name                = string
    port                                = number
    maintenance_window                  = string
    snapshot_retention_limit            = number
    snapshot_window                     = string
    cluster_mode_enabled                = bool
    num_node_groups                     = number
    replicas_per_node_group             = number
    subnet_keys                         = list(string)
    security_group_keys                 = list(string)
    create_log_group                    = bool
    log_group_retention_in_days         = number
    apply_immediately                   = bool
    at_rest_encryption_enabled          = bool
    transit_encryption_enabled          = bool
    tags                                = map(string)
  }))
}
