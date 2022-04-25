resource "aws_lb" "service1" {
  name               = "${var.service1_name}-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.service1_alb.id]
  subnets            = module.vpc.public_subnets
 
  enable_deletion_protection = false
}
 
resource "aws_alb_target_group" "service1" {
  name        = "${var.service1_name}-tg-${var.environment}"
  port        = var.service1_target_group_port
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"
 
  health_check {
   healthy_threshold   = "3"
   interval            = "30"
   protocol            = "HTTP"
   matcher             = "200,302"
   timeout             = "3"
   path                = var.service1_health_check_path
   unhealthy_threshold = "2"
  }
}

# resource "aws_alb_listener" "service1_http" {
#   load_balancer_arn = aws_lb.service1.id
#   port              = 80
#   protocol          = "HTTP"


#    default_action {
#     type             = "forward"
#     target_group_arn = aws_alb_target_group.service1.arn
#   }

# }
 
resource "aws_alb_listener" "service1_https" {
  load_balancer_arn = aws_lb.service1.arn
  port              = 443
  protocol          = "HTTPS"
 
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.alb_tls_cert_arn
 
  default_action {
    target_group_arn = aws_alb_target_group.service1.arn
    type             = "forward"
  }
}

resource "aws_alb_listener" "http_to_https" {
  load_balancer_arn = aws_lb.service1.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
   type = "redirect"
 
   redirect {
     port        = 443
     protocol    = "HTTPS"
     status_code = "HTTP_301"
   }
  }
}