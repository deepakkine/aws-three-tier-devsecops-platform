############################################
# Metrics Server
############################################

resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server"
  chart      = "metrics-server"
  version    = "3.13.0"

  namespace        = var.namespace
  create_namespace = false

  wait    = true
  timeout = 300

  values = [
    yamlencode({
      replicas = 1
    })
  ]
}