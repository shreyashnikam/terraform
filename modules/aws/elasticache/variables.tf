variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "subnet_id_map" {
  type        = map(string)
  description = "Map of subnet name to subnet ID"
}

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
