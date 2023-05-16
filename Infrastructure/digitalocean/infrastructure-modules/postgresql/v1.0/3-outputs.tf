output "postgres_cluster_id" {
  value = var.postgre_enabled ? digitalocean_database_cluster.this.0.id : null
}