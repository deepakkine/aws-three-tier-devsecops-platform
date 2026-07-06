output "release_name" {
  value = helm_release.ingress_nginx.name
}

output "namespace" {
  value = helm_release.ingress_nginx.namespace
}