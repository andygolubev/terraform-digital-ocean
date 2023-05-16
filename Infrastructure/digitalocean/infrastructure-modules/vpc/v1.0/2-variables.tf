variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR (Classless Inter-Domain Routing)"
  type        = string
  default     = "10.0.0.0/24"
}

variable "digitalocean_region" {
  description = "Digital Ocean region"
  type        = string
}

variable "vpc_enabled" {
  description = "pool_1_enabled"
  type        = bool
  default     = false
}
