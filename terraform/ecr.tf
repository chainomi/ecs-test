
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

## Build docker images and push to ECR
resource "docker_registry_image" "service1" {
    for_each = toset(var.repository_list)
    name = "${aws_ecr_repository.repository[each.key].repository_url}:${var.container_image_service1_version}"

    build {
        context = "../${each.key}"
        dockerfile = "Dockerfile"
    }  
}