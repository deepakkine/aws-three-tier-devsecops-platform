output "cluster_name" {
  description = "EKS Cluster Name"
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "EKS API Endpoint"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_ca_certificate" {
  description = "EKS Cluster CA Certificate"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}

output "cluster_security_group_id" {
  description = "EKS Cluster Security Group"
  value       = aws_security_group.eks_cluster.id
}

output "node_group_name" {
  description = "Managed Node Group Name"
  value       = aws_eks_node_group.this.node_group_name
}

output "cluster_arn" {
  description = "EKS Cluster ARN"
  value       = aws_eks_cluster.this.arn
}

output "oidc_issuer" {
  description = "OIDC Issuer URL"
  value       = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

output "oidc_provider_arn" {
  description = "IAM OIDC Provider ARN"
  value       = aws_iam_openid_connect_provider.eks.arn
}