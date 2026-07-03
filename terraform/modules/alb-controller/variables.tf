variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDC Provider ARN"
  type        = string
}

variable "oidc_provider_url" {
  description = "OIDC Provider URL"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
  default     = "kube-system"
}

variable "service_account_name" {
  description = "AWS Load Balancer Controller Service Account"
  type        = string
  default     = "aws-load-balancer-controller"
}