variable "target_groups" {
  description = "Map of target groups for ALBs"
  type = map(object({
    alb_name            = string
    deregistration_delay = number
    health_check        = object({
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
    name                = string
    port                = number
    protocol            = string
    protocol_version    = string
    slow_start          = number
    stickiness          = object({
      enabled         = bool
      type            = string
      cookie_duration = number
    })
    tags                = map(string)
    target_type         = string
  }))
  default = {}
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

variable "domain_name" {
  type = string
  description = "Fully qualified domain name for public ALB"
}

variable "certificate_arn" {
  type        = string
  description = "ARN of the ACM certificate to attach to the HTTPS listener"
}


variable "env" {
  type        = string
  description = "Environment name (dev, stage, prod)"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the ALB"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR for the ALB"
}

variable "subnet_id_map" {
  description = "Map of subnet names to their subnet IDs"
  type        = map(string)
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}

variable "region_name" {
  type        = string
  description = "Region Name"
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