terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }

  backend "s3" {
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    endpoint                    = "https://fra1.digitaloceanspaces.com"
    region                      = "us-east-1" // needed for this section, don't touch
    key                         = "infrastructure/test-v1/terraform-stage2.tfstate"
    
    # USE THIS FOR THE MAIN DIGITAL OCEAN ACCOUNT
    bucket                     = "terraform-state-sandbox"
  }
}



# Configure the DigitalOcean Provider
variable "digital_ocean_api_token" {
  description = "Digital Ocean token"
  type        = string
}
variable "k8s_cluster_name" {
  description = "Kubernetes cluster name"
  type        = string
}


provider "digitalocean" {
  token = var.digital_ocean_api_token
}
provider "kubernetes" {
  config_path    = "~/.kube/config"
}

#
# RESOURCES
#


module "kubernetes-config" {
  source = "../../../infrastructure-modules/kubernetes-config/v1.0"
  
  digital_ocean_api_token_for_k8s_config = var.digital_ocean_api_token
  k8s_config_cluster_name = var.k8s_cluster_name


  domain = "kuber.work"
  service1-subdomain = "service-1-test-morning"
  service2-subdomain = "service-2-test-afternoon"
  service3-subdomain = "service-3-test-evening"
  lb-workaround-subdomain = "lb-workaround-test"
  service1-service = "goodmorning" 
  service2-service = "goodafternoon" 
  service3-service = "goodevening" 
  cluster-issuer = "letsencrypt-prod" # letsencrypt-prod or letsencrypt-staging
  ssl-redirect = "false" # To accommodate the requirement for the service to respond on HTTP, a temporary value is assigned for certificate issuing.

}