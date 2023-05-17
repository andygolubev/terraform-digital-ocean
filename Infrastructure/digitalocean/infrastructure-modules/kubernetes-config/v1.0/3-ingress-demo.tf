resource "kubernetes_namespace_v1" "demo-ingress-namespace" {
  metadata {
    name = "demo-ingress"
  }

    depends_on = [
    null_resource.kubeconfig_save,
    kubernetes_manifest.cluster-issuer-prod,
    kubernetes_manifest.cluster-issuer-staging

  ]
}

resource "kubernetes_ingress_v1" "demo-ingress" {
  wait_for_load_balancer = false
  metadata {
    name      = "demo-ingress"
    namespace = kubernetes_namespace_v1.demo-ingress-namespace.metadata[0].name

    annotations = {
      "cert-manager.io/cluster-issuer" = "${var.cluster-issuer}"
      "kubernetes.io/ingress.class"   = "nginx"
      "nginx.ingress.kubernetes.io/ssl-redirect" = "${var.ssl-redirect}"
    }
  }

  spec {
    tls {
      hosts = [
        "${var.service1-subdomain}.${var.domain}",
        "${var.service2-subdomain}.${var.domain}",
        "${var.service3-subdomain}.${var.domain}"
      ]

      secret_name = "demo-tls"
    }

    rule {
      host = "${var.service1-subdomain}.${var.domain}"

      http {
        path {
          path_type = "Prefix"
          path      = "/"

          backend {
            service {
              name = "${var.service1-service}"
              port {
                number = 80
              }
            }
          }
        }
      }
    }

    rule {
      host = "${var.service2-subdomain}.${var.domain}"

      http {
        path {
          path_type = "Prefix"
          path      = "/"

          backend {
            service {
              name = "${var.service2-service}"
              port {
                number = 80
            }

            }
          }
        }
      }
    }

    rule {
      host = "${var.service3-subdomain}.${var.domain}"

      http {
        path {
          path_type = "Prefix"
          path      = "/"

          backend {
            service {
              name = "${var.service3-service}"
              port {
                number = 80
            }

            }
          }
        }
      }
    }

    default_backend {
      service {
        name = "pagenotfound"
        port {
          number = 80
        }
      }
    }
  }

  depends_on = [
      null_resource.kubeconfig_save,
      kubernetes_namespace_v1.demo-ingress-namespace,
  ]
}

resource "kubernetes_service_v1" "ingress-nginx-controller" {
  metadata {
    name = "ingress-nginx-controller"
    namespace = "ingress-nginx"    

    annotations = {
      "service.beta.kubernetes.io/do-loadbalancer-enable-proxy-protocol" = "true"
      "service.beta.kubernetes.io/do-loadbalancer-hostname" = "${var.lb-workaround-subdomain}.${var.domain}"
    }

    labels = {
      "helm.sh/chart" = "ingress-nginx-4.0.6"
      "app.kubernetes.io/name" = "ingress-nginx"
      "app.kubernetes.io/instance" = "ingress-nginx"
      "app.kubernetes.io/version" = "1.1.1"
      "app.kubernetes.io/managed-by" = "Helm"
      "app.kubernetes.io/component" = "controller"
    }
  }

  spec {
    selector = {
      "app.kubernetes.io/name" = "ingress-nginx"
      "app.kubernetes.io/instance" = "ingress-nginx"
      "app.kubernetes.io/component" = "controller"
    }

    type = "LoadBalancer"
    external_traffic_policy = "Local"

    port {
      name = "http"
      port = 80
      protocol = "TCP"
      target_port = "http"
    }

    port {
      name = "https"
      port = 443
      protocol = "TCP"
      target_port = "https"
    }
  }

    depends_on = [
      null_resource.kubeconfig_save,
  ]
}












