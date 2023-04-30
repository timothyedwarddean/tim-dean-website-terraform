resource "aws_route53_zone" "tdean_route_53_zone" {
  name = "tim-dean.com"
}

resource "aws_route53_record" "tdean_route_53_record" {
  allow_overwrite = true
  name            = "tim-dean.com"
  ttl             = 172800
  type            = "NS"
  zone_id         = aws_route53_zone.tdean_route_53_zone.zone_id

  records = [
    var.name_servers[0],
    var.name_servers[1],
  ]
}