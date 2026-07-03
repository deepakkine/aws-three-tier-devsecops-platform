output "iam_role_arn" {
  description = "IAM Role ARN for AWS Load Balancer Controller"
  value       = aws_iam_role.alb_controller.arn
}

output "iam_policy_arn" {
  description = "IAM Policy ARN"
  value       = aws_iam_policy.alb_controller.arn
}