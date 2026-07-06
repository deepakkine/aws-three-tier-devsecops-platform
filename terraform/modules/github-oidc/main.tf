############################################
# GitHub OIDC Provider
############################################

resource "aws_iam_openid_connect_provider" "github" {

  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    "22ff89586561fc2d52f77491e9f1eff1b80be33e"
  ]
}

############################################
# GitHub OIDC Trust Policy
############################################

data "aws_iam_policy_document" "github_oidc_assume_role" {

  statement {

    effect = "Allow"

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type = "Federated"

      identifiers = [
        aws_iam_openid_connect_provider.github.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "repo:${var.github_owner}/${var.github_repository}:ref:refs/heads/main"
      ]
    }
  }
}

############################################
# GitHub Actions IAM Role
############################################

resource "aws_iam_role" "github_actions" {

  name = "${var.project_name}-${var.environment}-github-actions"

  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

############################################
# GitHub Actions IAM Policy
############################################

resource "aws_iam_policy" "github_actions" {

  name        = "${var.project_name}-${var.environment}-github-actions"
  description = "Least privilege policy for GitHub Actions CI/CD"

  policy = file("${path.module}/iam-policy.json")
}

############################################
# Attach Policy
############################################

resource "aws_iam_role_policy_attachment" "github_actions" {

  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.github_actions.arn
}