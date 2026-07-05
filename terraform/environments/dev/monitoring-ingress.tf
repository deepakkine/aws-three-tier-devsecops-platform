resource "kubernetes_ingress_v1" "monitoring" {

  metadata {
    name      = "monitoring-ingress"
    namespace = "monitoring"

    annotations = {
      "cert-manager.io/cluster-issuer"              = "letsencrypt-prod"
      "nginx.ingress.kubernetes.io/ssl-redirect"    = "true"
      "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true"
    }
  }

  spec {
    ingress_class_name = "nginx"

    tls {
      hosts = [
        "grafana.deepakkine.online",
        "prometheus.deepakkine.online"
      ]

      secret_name = "monitoring-tls"
    }

    # Rules...
  }
}