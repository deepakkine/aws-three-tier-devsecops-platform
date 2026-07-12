################################################################################
# Variables
################################################################################

PROJECT_NAME := aws-three-tier-devsecops-platform

TF_DIR := terraform/environments/dev

HELM_DIR := helm/three-tier-app

NAMESPACE := three-tier-app

################################################################################
# Default
################################################################################

.DEFAULT_GOAL := help

################################################################################
# Help
################################################################################

help: ## Show available commands
	@echo ""
	@echo "=============================================="
	@echo " $(PROJECT_NAME)"
	@echo "=============================================="
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'
	@echo ""

################################################################################
# Terraform
################################################################################

fmt: ## Format Terraform code
	terraform fmt -recursive

init: ## Initialize Terraform
	cd $(TF_DIR) && terraform init

validate: ## Validate Terraform
	cd $(TF_DIR) && terraform validate

plan: ## Terraform Plan
	cd $(TF_DIR) && terraform plan

apply: ## Terraform Apply
	cd $(TF_DIR) && terraform apply

destroy: ## Terraform Destroy
	cd $(TF_DIR) && terraform destroy

################################################################################
# Kubernetes
################################################################################

pods: ## Show Pods
	kubectl get pods -A

nodes: ## Show Nodes
	kubectl get nodes

svc: ## Show Services
	kubectl get svc -A

ingress: ## Show Ingress
	kubectl get ingress -A

################################################################################
# Helm
################################################################################

helm-lint: ## Lint Helm Chart
	helm lint $(HELM_DIR)

helm-template: ## Render Helm Templates
	helm template three-tier-app $(HELM_DIR)

helm-install: ## Install Helm Chart
	helm upgrade --install three-tier-app $(HELM_DIR) \
		-n $(NAMESPACE) \
		--create-namespace

helm-uninstall: ## Remove Helm Release
	helm uninstall three-tier-app -n $(NAMESPACE)

################################################################################
# Monitoring
################################################################################

grafana: ## Open Grafana
	kubectl port-forward svc/kube-prometheus-stack-grafana 3000:80 -n monitoring

prometheus: ## Open Prometheus
	kubectl port-forward svc/kube-prometheus-stack-prometheus 9090:9090 -n monitoring

################################################################################
# Docker
################################################################################

docker-build: ## Build Backend Image
	docker compose build

docker-up: ## Start Local Containers
	docker compose up -d

docker-down: ## Stop Local Containers
	docker compose down

################################################################################
# Git
################################################################################

status: ## Git Status
	git status

pull: ## Git Pull
	git pull

push: ## Git Push
	git push

################################################################################
# Cleanup
################################################################################

clean: ## Remove Terraform Cache
	find . -type d -name ".terraform" -exec rm -rf {} +
	find . -type f -name "*.tfplan" -delete

################################################################################
# Information
################################################################################

info: ## Show Project Information
	@echo "Project   : $(PROJECT_NAME)"
	@echo "Terraform : $(TF_DIR)"
	@echo "Helm      : $(HELM_DIR)"
	@echo "Namespace : $(NAMESPACE)"