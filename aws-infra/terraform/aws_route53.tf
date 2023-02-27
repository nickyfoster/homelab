data "aws_route53_zone" "public" {
  name = "mrf0str.com"
}

resource "aws_route53_record" "vpn" {
  zone_id = data.aws_route53_zone.public.id

  name = "vpn.${data.aws_route53_zone.public.name}"
  type = "A"

  ttl = "300"

  records = [aws_eip.bastion.public_ip]
}


# resource "aws_route53_zone" "private" {
#   name = "example.com"

#   vpc {
#     vpc_id = data.aws_vpc.default_vpc.id
#   }
# }