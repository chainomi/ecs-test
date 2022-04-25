data "aws_route53_zone" "service1" {
  name         = var.route_53_hosted_zone_domain_name
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.service1.zone_id
  name    = var.route_53_domain_name_service1
  type    = "A"

  alias {
    name                   = aws_lb.service1.dns_name
    zone_id                = aws_lb.service1.zone_id
    evaluate_target_health = true
  }
}