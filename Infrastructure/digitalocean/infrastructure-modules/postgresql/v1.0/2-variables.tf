variable "digitalocean_project_id" {
  description = "Project name"
  type        = string
}

variable "digitalocean_region" {
  description = "Digital Ocean region"
  type        = string
}

variable "postgre_enabled" {
  description = "Do you require a postgre db?"
  type        = bool
  default     = false
}

variable "posgre_cluster_name" {
  description = "DB cluster name"
  type        = string  
}

variable "vpc_id" {
  description = "VPC_id for a kubernetes and other resources"
  type        = string  
}

variable "posgre_cluster_version" {
  description = "DB cluster version"
  type        = string  
  default     = "15"
}

variable "posgre_cluster_node_size" {
  description = "DB cluster node size"
  type        = string  
  default     = "db-s-1vcpu-1gb"
}

variable "posgre_cluster_node_count" {
  description = "DB cluster node count"
  type        = number  
  default     = 1
}

variable "tags" {
  type = list(string)
}



