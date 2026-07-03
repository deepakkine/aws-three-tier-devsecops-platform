############################################
# VPC Outputs
############################################

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "nat_gateway_id" {
  value = module.vpc.nat_gateway_id
}

############################################
# ECR Outputs
############################################

output "ecr_repository_urls" {
  description = "Amazon ECR Repository URLs"
  value       = module.ecr.repository_urls
}

output "ecr_repository_arns" {
  description = "Amazon ECR Repository ARNs"
  value       = module.ecr.repository_arns
}

############################################
# EKS Outputs
############################################

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_ca_certificate" {
  value     = module.eks.cluster_ca_certificate
  sensitive = true
}