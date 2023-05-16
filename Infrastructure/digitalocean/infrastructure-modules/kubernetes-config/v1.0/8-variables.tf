variable "k8s_config_cluster_name" {
  description = "k8s_config_cluster_name"
  type        = string
}

variable "digital_ocean_api_token_for_k8s_config" {
  description = "DO token for kube config save"
  type        = string
}


variable "domain" {
  type = string
}

variable "service1-subdomain" {
  type = string
}

variable "service2-subdomain" {
  type = string
}

variable "service3-subdomain" {
  type = string
}

variable "lb-workaround-subdomain" {
  type = string
}

variable "service1-service" {
  description = "Name of the editor service from deployment"
  type = string
}

variable "service2-service" {
  description = "Name of the admin service from deployment"
  type = string
}

variable "service3-service" {
  description = "Name of the jobbe service from deployment"
  type = string
}

variable "cluster-issuer" {
  description = "Name of cluster issuer: letsencrypt-staging or letsencrypt-prod"
  type = string
  default = "letsencrypt-staging"
}



