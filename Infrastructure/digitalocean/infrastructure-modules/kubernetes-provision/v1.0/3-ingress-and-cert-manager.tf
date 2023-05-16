resource "null_resource" "nginx_ingress_apply" {
    provisioner "local-exec" {
        command = "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.1/deploy/static/provider/do/deploy.yaml; kubectl delete service/ingress-nginx-controller -n ingress-nginx; kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission"
    
    # this is a workaround to avoid webhook waiting error
    # kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission

    # this workaround is for avoiding an error with "Controller already exists"
    # kubectl delete service/ingress-nginx-controller -n ingress-nginx; 
    }

    # Run this command only for new cluster (if cluster id has changed)
    triggers = {
        cluster_default_pool_node_size = digitalocean_kubernetes_cluster.this.node_pool[0].size
    }
    depends_on = [
        null_resource.kubeconfig_save,
    ]
}

resource "null_resource" "cert_manager_apply" {
    provisioner "local-exec" {
        command = "kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.7.1/cert-manager.yaml"
    }

    # Run this command only for new cluster (if cluster id has changed)
    triggers = {
        cluster_default_pool_node_size = digitalocean_kubernetes_cluster.this.node_pool[0].size
    }
    depends_on = [
        null_resource.kubeconfig_save,
    ]
}