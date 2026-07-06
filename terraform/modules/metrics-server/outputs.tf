output "release_name" {
  value = helm_release.metrics_server.name
}

output "namespace" {
  value = helm_release.metrics_server.namespace
}