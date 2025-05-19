variable "subnet_id_map" {
  description = "Map of subnet name => subnet ID, from VPC module"
  type        = map(string)
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR for the ALB"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

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
