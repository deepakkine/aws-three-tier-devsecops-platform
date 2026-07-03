############################################
# kube-prometheus-stack
############################################

resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "77.4.0"

  namespace        = "monitoring"
  create_namespace = true

  wait    = true
  timeout = 900

  set = [
    {
      name  = "grafana.adminPassword"
      value = "admin123"
    },
    {
      name  = "grafana.service.type"
      value = "ClusterIP"
    },
    {
      name  = "prometheus.prometheusSpec.retention"
      value = "7d"
    },
    {
      name  = "alertmanager.enabled"
      value = "true"
    },
    {
      name  = "grafana.persistence.enabled"
      value = "false"
    },
    {
      name  = "prometheus.prometheusSpec.storageSpec"
      value = ""
    }
  ]

  depends_on = [
    helm_release.metrics_server
  ]
}