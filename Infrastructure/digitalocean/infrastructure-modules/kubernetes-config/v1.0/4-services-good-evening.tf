# This is a goodevening service. I use is a mock when I want to issue certificates by cert-manager, that requires services to response with 200 status.

resource "kubernetes_manifest" "goodevening-service" {
  manifest = yamldecode(<<-EOF
apiVersion: v1
kind: Service
metadata:
  name: goodevening
  namespace: demo-ingress
spec:
  ports:
  - port: 80
    targetPort: 5678
  selector:
    app: goodevening
EOF
  )
  depends_on = [
    null_resource.kubeconfig_save,
    kubernetes_namespace_v1.demo-ingress-namespace,
  ]

}

resource "kubernetes_manifest" "goodevening-service-deployment" {
  manifest = yamldecode(<<-EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: goodevening
  namespace: demo-ingress
spec:
  selector:
    matchLabels:
      app: goodevening
  replicas: 2
  template:
    metadata:
      labels:
        app: goodevening
    spec:
      containers:
      - name: goodevening
        image: hashicorp/http-echo
        args:
        - "-text=Good Evening!"
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
                      - goodevening
              topologyKey: "kubernetes.io/hostname"
EOF
  )

  depends_on = [
    null_resource.kubeconfig_save,
    kubernetes_namespace_v1.demo-ingress-namespace,
  ]

}