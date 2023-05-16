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
    key                         = "infrastructure/test-v1/terraform-stage1.tfstate"
    
    # USE THIS FOR THE MAIN DIGITAL OCEAN ACCOUNT
    bucket                     = "terraform-state-sandbox"  
  }
}


# Configure the DigitalOcean Provider
variable "digital_ocean_api_token" {
  description = "Digital Ocean token"
  type        = string
}
provider "digitalocean" {
  token = var.digital_ocean_api_token
}

#
# RESOURCES
#

resource "digitalocean_project" "this" {
  name        = "infra-test-v1" #Edit
  description = "infra-test-v1" #Edit
  purpose     = "Web Application"
  environment = "Development"
}

variable "user_defined_tags" {
  description = "Tags for resources"
  type        = list(string)
  default     = [ "Created-by-terraform", "test-env", "test-account" ] #Edit
}

module "vpc" {
  source = "../../../infrastructure-modules/vpc/v1.0"

  vpc_name             = "vpc-test" #Edit
  vpc_cidr_block       = "10.0.0.0/24"
  digitalocean_region  = "fra1"
  
}

module "kubernetes-provision" {
    source = "../../../infrastructure-modules/kubernetes-provision/v1.0"

    k8s_version_prefix = "1.26."
    k8s_cluster_name = "demo-cluster-test-v1" #Edit
    digitalocean_region_for_k8s = "fra1"
    k8s_auto_upgrade = false
    vpc_id = module.vpc.vpc_id

    #sizes to choose: 
    #       "s-1vcpu-2gb"
    #       "s-2vcpu-4gb"
    #       "s-4vcpu-8gb"

    # Mandatory pool that must exist
    k8s_embedded_pool_size = "s-2vcpu-4gb" #Edit
    k8s_embedded_pool_nodes_count = 1 #Edit

    # Type "true" if you want this pool of nodes
    pool_1_enabled = true #Edit
    k8s_pool_1_size = "s-2vcpu-4gb" #Edit
    k8s_pool_1_nodes_count = 1 #Edit

    # Type "true" if you want this pool of nodes
    pool_2_enabled = false #Edit
    k8s_pool_2_size = "s-2vcpu-4gb" #Edit
    k8s_pool_2_nodes_count = 1 #Edit

    digital_ocean_api_token_for_k8s = var.digital_ocean_api_token
    digitalocean_project_id = digitalocean_project.this.id

    tags = var.user_defined_tags

    depends_on = [ module.vpc, digitalocean_project.this,]
}

module "postgresql" {
    source = "../../../infrastructure-modules/postgresql/v1.0"

    digitalocean_project_id = digitalocean_project.this.id
    digitalocean_region = "fra1"
    postgre_enabled = true
    posgre_cluster_name = "postgresql-demo-test-v1"
    posgre_cluster_version = "15"
    posgre_cluster_node_size = "db-s-1vcpu-1gb"
    posgre_cluster_node_count = 1
    vpc_id = module.vpc.vpc_id

    tags = var.user_defined_tags

    depends_on = [ module.vpc, digitalocean_project.this,]
}