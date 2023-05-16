output "k8s_cluster_ingress_load_balancer_id" {
    value = data.digitalocean_loadbalancer.this.id
}

output "k8s_cluster_ingress_load_balancer_ip" {
    value = data.digitalocean_loadbalancer.this.ip
}


