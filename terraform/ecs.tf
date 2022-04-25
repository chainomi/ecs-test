
# ECS cluster
resource "aws_ecs_cluster" "application" {
  name = "${var.environment}-${var.application_name}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
      "environment" = "${var.environment}" 
  }
}



resource "aws_ecs_service" "service1" {
 name                               = "${var.container_name_service1}" #must be the same as container name in task definition
 cluster                            = aws_ecs_cluster.application.id
 task_definition                    = aws_ecs_task_definition.service1.arn
 desired_count                      = 1
 deployment_minimum_healthy_percent = 50
 deployment_maximum_percent         = 200
 launch_type                        = "FARGATE"
 platform_version                   = "LATEST"
 scheduling_strategy                = "REPLICA"
 
 network_configuration {
   security_groups  = [aws_security_group.service1.id]
   subnets          = module.vpc.private_subnets
   assign_public_ip = false
 }

  service_registries {
    registry_arn = aws_service_discovery_service.service1.arn
    container_name = "${var.container_name_service1}"
  }
 
 load_balancer {
   target_group_arn = aws_alb_target_group.service1.arn
   container_name   = "${var.container_name_service1}"
   container_port   = var.container_port_service1
 }
 
 lifecycle {
   ignore_changes = [task_definition, desired_count]
 }
}



#log group for container logs
resource "aws_cloudwatch_log_group" "service1" {
  name = "/ecs/${var.service1_name}-task-${var.environment}"

  tags = {
    Name        = "${var.service1_name}-task-${var.environment}"
    Environment = var.environment
  }
}
