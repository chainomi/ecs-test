
#pulling data for ecr
data "aws_caller_identity" "current" {}

data "aws_ecr_authorization_token" "token" {}

locals {

  aws_ecr_url = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com"
}

## Create ECR repository
resource "aws_ecr_repository" "repository" {
    for_each = toset(var.repository_list)
  name = each.key
}
