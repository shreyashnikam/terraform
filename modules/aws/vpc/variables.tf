variable "region" {
  description = "AWS region"
  type        = string
}

variable "env" {
  description = "Environment name (e.g., dev, stage, prod)"
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