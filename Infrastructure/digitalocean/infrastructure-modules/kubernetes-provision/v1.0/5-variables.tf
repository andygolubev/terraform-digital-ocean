variable "digital_ocean_api_token_for_k8s" {
  description = "DO token for kube config save"
  type        = string
}

variable "digitalocean_project_id" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "VPC_id for a kubernetes and other resources"
  type        = string  
}

variable "k8s_version_prefix" {
  description = "Kubernetes version prefix"
  type        = string
  default     = "1.26."
}

variable "k8s_cluster_name" {
  description = "Cluster name"
  type        = string
}

variable "digitalocean_region_for_k8s" {
  description = "Digital Ocean region"
  type        = string
}

variable "k8s_auto_upgrade" {
  description = "k8s_auto_upgrade"
  type        = bool
  default     = false
}


variable "k8s_embedded_pool_size" {
  description = "k8s_embedded_pool_size"
  type        = string
}

variable "k8s_embedded_pool_nodes_count" {
  description = "k8s_embedded_pool_nodes_count"
  type        = number
  default     = 1
}


variable "pool_1_enabled" {
  description = "pool_1_enabled"
  type        = bool
  default     = false
}

variable "k8s_pool_1_size" {
  description = "k8s_pool_1_size"
  type        = string
}

variable "k8s_pool_1_nodes_count" {
  description = "k8s_pool_1_nodes_count"
  type        = number
  default     = 1
}

variable "pool_2_enabled" {
  description = "pool_2_enabled"
  type        = bool
  default     = false
}

variable "k8s_pool_2_size" {
  description = "k8s_pool_2_size"
  type        = string
}

variable "k8s_pool_2_nodes_count" {
  description = "k8s_pool_2_nodes_count"
  type        = number
  default     = 1
}

variable "tags" {
  type = list(string)
}
