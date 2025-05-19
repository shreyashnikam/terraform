variable "domain_name" {
  description = "The main domain to issue the cert for (e.g. stage.pratilipi.com)"
  type        = string
}

variable "zone_name" {
  description = "The name of the hosted zone (e.g. stage.pratilipi.com)"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "region_name" {
  description = "Region Name"
  type        = string
}