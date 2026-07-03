resource "aws_iam_policy" "alb_controller" {
  name        = local.resource_name
  description = "IAM Policy for AWS Load Balancer Controller"

  policy = file("${path.module}/policy/iam_policy.json")
}