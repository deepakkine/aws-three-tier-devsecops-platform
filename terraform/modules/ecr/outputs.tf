############################################
# ECR Repository URLs
############################################

output "repository_urls" {
  description = "ECR repository URLs"

  value = {
    for repo_name, repo in aws_ecr_repository.this :
    repo_name => repo.repository_url
  }
}

############################################
# ECR Repository ARNs
############################################

output "repository_arns" {
  description = "ECR repository ARNs"

  value = {
    for repo_name, repo in aws_ecr_repository.this :
    repo_name => repo.arn
  }
}