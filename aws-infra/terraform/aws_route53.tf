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


resource "aws_route53_zone" "private" {
  name = var.private_zone_name

  vpc {
    vpc_id = data.aws_vpc.default_vpc.id
  }
}

resource "aws_route53_record" "private_zone_record" {
  for_each = { for host in var.private_hosts : host.name => host }

  zone_id = aws_route53_zone.private.id

  name = "${each.key}.${aws_route53_zone.private.name}"
  type = "A"

  ttl = "300"

  records = [aws_instance.private_instance[each.key].private_ip]
}