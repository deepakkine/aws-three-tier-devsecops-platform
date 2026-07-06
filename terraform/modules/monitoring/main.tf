############################################
# kube-prometheus-stack
############################################

resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "77.4.0"

  namespace        = var.namespace
  create_namespace = true

  wait    = true
  timeout = 900

  values = [
    templatefile("${path.module}/alertmanager-values.yaml.tpl", {
      alertmanager_email          = var.alertmanager_email
      alertmanager_email_password = var.alertmanager_email_password
    })
  ]

  set = [
    {
      name  = "grafana.adminPassword"
      value = var.grafana_admin_password
    },
    {
      name  = "grafana.service.type"
      value = "ClusterIP"
    },
    {
      name  = "prometheus.prometheusSpec.retention"
      value = var.prometheus_retention
    },
    {
      name  = "alertmanager.enabled"
      value = "true"
    },
    {
      name  = "grafana.persistence.enabled"
      value = var.grafana_persistence_enabled
    },
    {
      name  = "prometheus.prometheusSpec.storageSpec"
      value = ""
    }
  ]
}