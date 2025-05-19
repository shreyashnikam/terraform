variable "env" {
  default = "stage"
}

variable "region_name" {
  default = "ap-south-1"
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "instance_type" {
  default = "t3.medium"
}

variable "key_name" {
  default = "stage-key"
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

variable "tags" {
  default = {
    Environment = "stage"
    Project     = "stage-iac"
  }
}

variable "public_key_path" {
  type        = string
  description = "Path to public key file for EC2 key pair"
}

variable "subnet_id_map" {
  description = "Map of subnet names to their subnet IDs"
  type        = map(string)
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR for the ALB"
}

variable "image_id" {
  description = "ECS optimized aws image id"
  type        = string
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
  }))
}

variable "target_group_arns" {
  description = "Map of target group names to their ARNs"
  type        = map(string)
  default     = {}
}

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

variable "log_retention_in_days" {
  type    = number
  default = 7
}