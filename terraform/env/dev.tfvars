#general
region="us-east-1"
application_name="quest-master"
environment="development"

#services
service1_name="quest-master"


#security groups
#alb
http_ingress_port="80"
https_ingress_port="443"

#word-press task
container_name_service1="quest-master"
# container_image_service1=""
container_image_service1_version="latest"
service1_cpu="512"
service1_memory="1024"
container_port_service1="3000"
host_port_service1="3000"

#ecr
repository_list=["quest-master"]

#alb
service1_health_check_path="/"

#target group
service1_target_group_port="3000"


#service discovery
service_private_dns_name="dev"


#route 53 domain
route_53_hosted_zone_domain_name="chainomi.link."
alb_tls_cert_arn="arn:aws:acm:us-east-1:488144151286:certificate/e7cc04b5-5346-41e4-976e-7be15be9c762"
route_53_domain_name_service1="quest-master.chainomi.link"
