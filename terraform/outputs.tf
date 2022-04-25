output "aws_account_id" {
  description = "Account ID for environment"
  value = data.aws_caller_identity.current.id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
    description = "cluster name"
    value = aws_ecs_cluster.application.name
}

output "service1_name" {
    description = "cluster name"
    value = aws_ecs_service.service1.name
}

output "load_balancer_dns" {
    value = aws_lb.service1.dns_name
  
}

output "repo_url" {
    value = aws_ecr_repository.repository["quest-master"].repository_url
}

