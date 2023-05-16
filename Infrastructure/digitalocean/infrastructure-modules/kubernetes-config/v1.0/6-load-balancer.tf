# This is the workaround to get Load balaner id, wich was created by the Kubernetes cluster.
# It uses doctl (digital ocean cli tool), so doctl must be authorized null_resource.kubeconfig_save resource

resource "local_file" "get_load_balancer_script" {
    content  = <<-EOF
    #!/bin/bash
    doctl kubernetes cluster list-associated-resources $1 -o json | jq '{ load_balancer_id: .load_balancers[0].id, load_balancer_name: .load_balancers[0].name }'
    EOF

    filename = "/tmp/get_load_balancer_id.sh"

    depends_on = [ kubernetes_ingress_v1.demo-ingress, ]
}

data "external" "load_balancer_details" {
    program = ["${local_file.get_load_balancer_script.filename}", "${var.k8s_config_cluster_name}"]
    depends_on = [ local_file.get_load_balancer_script, ]
}

data "digitalocean_loadbalancer" "this" {
  id = data.external.load_balancer_details.result.load_balancer_id
}