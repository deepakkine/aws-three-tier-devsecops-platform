terraform {
  backend "s3" {
    bucket         = "deepak-aws-three-tier-devsecops-tfstate-848504403730"
    key            = "bootstrap/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "deepak-aws-three-tier-devsecops-tf-lock"
    encrypt        = true
  }
}