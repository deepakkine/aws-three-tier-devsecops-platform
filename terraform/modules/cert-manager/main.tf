############################################
# cert-manager
############################################

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.18.2"

  namespace        = var.namespace
  create_namespace = true

  wait    = true
  timeout = 300

  set = [
    {
      name  = "crds.enabled"
      value = "true"
    }
  ]
}