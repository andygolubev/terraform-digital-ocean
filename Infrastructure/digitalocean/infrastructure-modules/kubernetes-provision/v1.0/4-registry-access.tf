resource "null_resource" "registry-access" {
    provisioner "local-exec" {
        command = "doctl registry kubernetes-manifest | kubectl apply -f -"
    }

    # Run this command only for new cluster (if cluster id has changed)
    triggers = {
        cluster_default_pool_node_size = digitalocean_kubernetes_cluster.this.node_pool[0].size
    }
    depends_on = [
        null_resource.kubeconfig_save,
    ]
}