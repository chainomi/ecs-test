
#load balancer security group
resource "aws_security_group" "service1_alb" {
  name   = "${var.service1_name}-sg-alb-${var.environment}"
  vpc_id = module.vpc.vpc_id
 
  ingress {
   protocol         = "tcp"
   from_port        = var.http_ingress_port
   to_port          = var.http_ingress_port
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
 
  ingress {
   protocol         = "tcp"
   from_port        = var.https_ingress_port
   to_port          = var.https_ingress_port
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
 
  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }

  revoke_rules_on_delete = true

  tags = {
    "Name"        = "${var.service1_name} load balancer security group"
    "Environment" = var.environment
  }

}

resource "aws_security_group" "service1" {
  name   = "${var.service1_name}-sg-task-${var.environment}"
  vpc_id = module.vpc.vpc_id
 
  ingress {
   protocol         = "tcp"
   from_port        = var.container_port_service1
   to_port          = var.container_port_service1
   
   #restricting ingress traffic from alb
   security_groups  = [aws_security_group.service1_alb.id]
  }
 
  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
  revoke_rules_on_delete = true

  tags = {
    "Name"        = "${var.service1_name} security group"
    "Environment" = var.environment
  }

}

