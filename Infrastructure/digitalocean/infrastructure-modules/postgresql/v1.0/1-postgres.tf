resource "digitalocean_database_cluster" "this" {
  count = var.postgre_enabled ? 1 : 0
  name       = var.posgre_cluster_name
  engine     = "pg"
  version    = var.posgre_cluster_version
  size       = var.posgre_cluster_node_size
  region     = var.digitalocean_region
  node_count = var.posgre_cluster_node_count

  private_network_uuid = var.vpc_id

  tags   = var.tags
}

resource "digitalocean_project_resources" "this" {
  count = var.postgre_enabled ? 1 : 0
  project = var.digitalocean_project_id
  resources = [
    digitalocean_database_cluster.this.0.urn
  ]
  
  depends_on = [ digitalocean_database_cluster.this, ]
}