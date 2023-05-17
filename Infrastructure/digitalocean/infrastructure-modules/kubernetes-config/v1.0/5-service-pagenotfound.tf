# This service shows 404 Page. I use it as a default backend in my ingress config

resource "kubernetes_manifest" "pagenotfound-service" {
  manifest = yamldecode(<<-EOF
apiVersion: v1
kind: Service
metadata:
  name: pagenotfound
  namespace: demo-ingress
spec:
  ports:
  - port: 80
    targetPort: 5678
  selector:
    app: pagenotfound
EOF
  )
  depends_on = [
    null_resource.kubeconfig_save,
    kubernetes_namespace_v1.demo-ingress-namespace,
  ]

}

resource "kubernetes_manifest" "pagenotfound-service-deployment" {
  manifest = yamldecode(<<-EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pagenotfound
  namespace: demo-ingress
spec:
  selector:
    matchLabels:
      app: pagenotfound
  replicas: 2
  template:
    metadata:
      labels:
        app: pagenotfound
    spec:
      containers:
      - name: pagenotfound
        image: hashicorp/http-echo
        args:
        - "-text=404 Page Not Found"
        ports:
        - containerPort: 5678
        resources:
          requests:
            memory: 64Mi
            cpu: 250m
          limits:
            memory: 128Mi
            cpu: 500m
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            - labelSelector:
                matchExpressions:
                  - key: app
                    operator: In
                    values:
                      - pagenotfound
              topologyKey: "kubernetes.io/hostname"
EOF
  )

  depends_on = [
    null_resource.kubeconfig_save,
    kubernetes_namespace_v1.demo-ingress-namespace,
  ]

}