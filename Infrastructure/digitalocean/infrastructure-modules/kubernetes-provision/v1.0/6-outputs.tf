output "k8s_cluster_id" {
  value = digitalocean_kubernetes_cluster.this.id
}

output "k8s_cluster_urn" {
  value = digitalocean_kubernetes_cluster.this.urn
}

output "k8s_cluster_name" {
  value = digitalocean_kubernetes_cluster.this.name
}

output "k8s_cluster_default_pool_size" {
  value = digitalocean_kubernetes_cluster.this.node_pool[0].size
}