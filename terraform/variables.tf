#general
variable "region" {}
variable "application_name" {}
variable "environment" {}

variable "service1_name" {}


#security groups
#alb
variable "http_ingress_port"{}
variable "https_ingress_port"{}

#quest app
variable "container_port_service1" {}
variable "host_port_service1" {}

variable "container_name_service1"{}
# variable "container_image_service1"{}
variable "container_image_service1_version"{}


variable "service1_health_check_path" {}

variable "service1_target_group_port" {}

variable "service_private_dns_name" {}


variable "service1_cpu" {}
variable "service1_memory" {}


variable "route_53_hosted_zone_domain_name" {}

variable "route_53_domain_name_service1" {}

variable "alb_tls_cert_arn" {}

variable "repository_list" {
  description = "List of repository names"
  type = list
}