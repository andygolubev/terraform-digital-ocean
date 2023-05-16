resource "null_resource" "kubeconfig_save" {
    provisioner "local-exec" {
        command = "doctl auth init --access-token ${var.digital_ocean_api_token_for_k8s} && doctl kubernetes cluster kubeconfig save ${digitalocean_kubernetes_cluster.this.name}"
    }

    # Run this resource each time for a proper pipeline work
    triggers = {
        timestamp = timestamp()
    }

    depends_on = [
        digitalocean_kubernetes_cluster.this,
    ]
}



