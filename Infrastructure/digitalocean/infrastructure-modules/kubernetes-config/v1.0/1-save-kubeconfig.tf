resource "null_resource" "kubeconfig_save" {
    provisioner "local-exec" {
        command = "doctl auth init --access-token ${var.digital_ocean_api_token_for_k8s_config} && doctl kubernetes cluster kubeconfig save ${var.k8s_config_cluster_name}"
    }

    # Run this resource each time
    triggers = {
        timestamp = timestamp()
    }
}
