data "template_file" "service1" {
  template = file("templates/questapp.json.tpl")

  vars = {
    container_name        = var.container_name_service1
    image_url             = "${aws_ecr_repository.repository["quest-master"].repository_url}"
    image_version         = var.container_image_service1_version
    cpu                   = var.service1_cpu
    memory                = var.service1_memory
    container_port        = var.container_port_service1
    host_port             = var.host_port_service1
    log_group             = aws_cloudwatch_log_group.service1.name 
    region                = var.region
  }
}

resource "aws_ecs_task_definition" "service1" {
  family                = "${var.service1_name}"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = var.service1_cpu
  memory                   = var.service1_memory
  network_mode = "awsvpc"
  container_definitions = data.template_file.service1.rendered
}

