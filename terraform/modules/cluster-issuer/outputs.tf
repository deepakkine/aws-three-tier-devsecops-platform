output "cluster_issuer_name" {
  description = "ClusterIssuer name"
  value       = kubernetes_manifest.cluster_issuer.manifest.metadata.name
}