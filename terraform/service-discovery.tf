resource "aws_service_discovery_private_dns_namespace" "service" {
  name        = var.service_private_dns_name
  description = "private dns or local namespace for ${var.service1_name} service"
  vpc         = module.vpc.vpc_id
}


resource "aws_service_discovery_service" "service1" {
  name = "${var.service1_name}"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.service.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

