# resource "aws_route53_record" "edgeone-record" {
#   zone_id = aws_route53_zone.devopslink-public-zone.zone_id
#   name    = "www.edgeone.com"
#   type    = "A"
#   ttl     = "300"
#   records = [aws_instance.${var.edgeone}.public_ip]
# }
