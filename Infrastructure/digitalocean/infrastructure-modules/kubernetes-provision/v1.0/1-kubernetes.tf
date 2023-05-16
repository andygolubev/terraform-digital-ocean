
data "digitalocean_kubernetes_versions" "this" {
  version_prefix = var.k8s_version_prefix
}

resource "digitalocean_kubernetes_cluster" "this" {
  name         = var.k8s_cluster_name
  region       = var.digitalocean_region_for_k8s
  auto_upgrade = var.k8s_auto_upgrade
  version      = data.digitalocean_kubernetes_versions.this.latest_version
  vpc_uuid     = var.vpc_id

  node_pool {
    name       = "embedded-pool"
    size       = var.k8s_embedded_pool_size
    node_count = var.k8s_embedded_pool_nodes_count
  }

  tags   = var.tags
}

resource "digitalocean_kubernetes_node_pool" "pool_1_enabled" {
  cluster_id = digitalocean_kubernetes_cluster.this.id
    count = var.pool_1_enabled ? 1 : 0
    name       = "pool-1"
    size       = var.k8s_pool_1_size
    node_count = var.k8s_pool_1_nodes_count

    tags   = var.tags
}

resource "digitalocean_kubernetes_node_pool" "pool_2_enabled" {
  cluster_id = digitalocean_kubernetes_cluster.this.id
    count = var.pool_2_enabled ? 1 : 0
    name       = "pool-2"
    size       = var.k8s_pool_2_size
    node_count = var.k8s_pool_2_nodes_count

    tags   = var.tags
}

resource "digitalocean_project_resources" "this" {
  project = var.digitalocean_project_id
  resources = [
    digitalocean_kubernetes_cluster.this.urn
  ]

  depends_on = [ digitalocean_kubernetes_cluster.this, ]
}