output "role_arn" {
  description = "GitHub Actions IAM Role ARN"
  value       = aws_iam_role.github_actions.arn
}

output "role_name" {
  description = "GitHub Actions IAM Role Name"
  value       = aws_iam_role.github_actions.name
}