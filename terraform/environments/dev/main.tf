##############################################
# Terraform Configuration for Dev Environment
##############################################

###############################################
# VPC
###############################################

module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  cluster_name = "${var.project_name}-${var.environment}"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

#############################################
# Amazon EKS
#############################################

module "eks" {
  source = "../../modules/eks"

  project_name = var.project_name
  environment  = var.environment

  cluster_name    = "${var.project_name}-${var.environment}"
  cluster_version = var.cluster_version

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids

  node_instance_types = var.node_instance_types

  desired_size = var.desired_size
  min_size     = var.min_size
  max_size     = var.max_size

  github_actions_user_arn = var.github_actions_user_arn
}

#############################################
# ALB Controller
#############################################

module "alb_controller" {
  source = "../../modules/alb-controller"

  cluster_name = module.eks.cluster_name

  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_issuer
}

############################################
# Amazon ECR
############################################

module "ecr" {
  source = "../../modules/ecr"

  project_name = var.project_name
  environment  = var.environment

  repositories = [
    "frontend",
    "backend"
  ]
}

############################################
# Monitoring
############################################

module "monitoring" {
  source = "../../modules/monitoring"

  namespace = "monitoring"

  alertmanager_email          = var.alertmanager_email
  alertmanager_email_password = var.alertmanager_email_password

  grafana_admin_password      = "admin123"
  prometheus_retention        = "7d"
  grafana_persistence_enabled = false

  depends_on = [
    module.metrics_server
  ]
}

module "metrics_server" {
  source = "../../modules/metrics-server"

  namespace = "kube-system"
}