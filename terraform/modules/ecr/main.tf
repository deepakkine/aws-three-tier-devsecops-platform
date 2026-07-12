############################################
# Amazon ECR Repositories
############################################

resource "aws_ecr_repository" "this" {
  for_each     = toset(var.repositories)
  force_delete = true

  name                 = "${local.name_prefix}-${each.value}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-${each.value}"
    }
  )
}