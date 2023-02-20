
resource "aws_route53_record" "_hostedzone_z0081144266dyo35drqi5_mrf0str_com__ns" {
  name    = "mrf0str.com"
  records = ["ns-1521.awsdns-62.org.", "ns-132.awsdns-16.com.", "ns-629.awsdns-14.net.", "ns-1727.awsdns-23.co.uk."]
  ttl     = 172800
  type    = "NS"
  zone_id = aws_route53_zone._hostedzone_z0081144266dyo35drqi5.id
}

resource "aws_route53_record" "_hostedzone_z0081144266dyo35drqi5_mrf0str_com__soa" {
  name    = "mrf0str.com"
  records = ["ns-1727.awsdns-23.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
  ttl     = 900
  type    = "SOA"
  zone_id = aws_route53_zone._hostedzone_z0081144266dyo35drqi5.id
}

resource "aws_route53_record" "_hostedzone_z0081144266dyo35drqi5_vpn_mrf0str_com__a" {
  name    = "vpn.mrf0str.com"
  records = [aws_eip.openvpn_server.public_ip]
  ttl     = 300
  type    = "A"
  zone_id = aws_route53_zone._hostedzone_z0081144266dyo35drqi5.id
}

resource "aws_route53_record" "_hostedzone_z08420171kozcjn28nk8w_cointracker_mrf0str_private_com__a" {
  name    = "redis.mrf0str-private.com"
  records = [aws_eip.redis.private_ip]
  ttl     = 300
  type    = "A"
  zone_id = aws_route53_zone._hostedzone_z08420171kozcjn28nk8w.id
}

resource "aws_route53_record" "_hostedzone_z08420171kozcjn28nk8w_hashtopolis_mrf0str_private_com__a" {
  name    = "hashtopolis.mrf0str-private.com"
  records = ["172.31.39.185"]
  ttl     = 300
  type    = "A"
  zone_id = aws_route53_zone._hostedzone_z08420171kozcjn28nk8w.id
}

resource "aws_route53_record" "_hostedzone_z08420171kozcjn28nk8w_infra_mrf0str_private_com__a" {
  name    = "infra.mrf0str-private.com"
  records = [aws_eip.mrf0str_infra_server.private_ip]
  ttl     = 300
  type    = "A"
  zone_id = aws_route53_zone._hostedzone_z08420171kozcjn28nk8w.id
}

resource "aws_route53_record" "_hostedzone_z08420171kozcjn28nk8w_mrf0str_private_com__ns" {
  name    = "mrf0str-private.com"
  records = ["ns-512.awsdns-00.net.", "ns-1536.awsdns-00.co.uk.", "ns-1024.awsdns-00.org.", "ns-0.awsdns-00.com."]
  ttl     = 172800
  type    = "NS"
  zone_id = aws_route53_zone._hostedzone_z08420171kozcjn28nk8w.id
}

resource "aws_route53_record" "_hostedzone_z08420171kozcjn28nk8w_mrf0str_private_com__soa" {
  name    = "mrf0str-private.com"
  records = ["ns-1536.awsdns-00.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
  ttl     = 900
  type    = "SOA"
  zone_id = aws_route53_zone._hostedzone_z08420171kozcjn28nk8w.id
}

resource "aws_route53_zone" "_hostedzone_z0081144266dyo35drqi5" {
  comment = "HostedZone created by Route53 Registrar"
  name    = "mrf0str.com"
}

resource "aws_route53_zone" "_hostedzone_z08420171kozcjn28nk8w" {
  name = "mrf0str-private.com"
  vpc {
    vpc_id     = aws_vpc.eu_east_main_vnet.id
    vpc_region = var.region
  }

}

resource "aws_route53_resolver_rule_association" "rslvr_autodefined_assoc_vpc_67b2050c_internet_resolver" {
  name             = "System Rule Association"
  resolver_rule_id = "rslvr-autodefined-rr-internet-resolver"
  vpc_id           = aws_vpc.eu_east_main_vnet.id
}

## K8s private records

resource "aws_route53_record" "k8s_controller" {
  name    = "k8s-controller.mrf0str-private.com"
  records = [aws_instance.k8s_controller.private_ip]
  ttl     = 300
  type    = "A"
  zone_id = aws_route53_zone._hostedzone_z08420171kozcjn28nk8w.id
}

resource "aws_route53_record" "k8s_node01" {
  name    = "k8s-node01.mrf0str-private.com"
  records = [aws_instance.k8s_node01.private_ip]
  ttl     = 300
  type    = "A"
  zone_id = aws_route53_zone._hostedzone_z08420171kozcjn28nk8w.id
}

resource "aws_route53_record" "k8s_node02" {
  name    = "k8s-node02.mrf0str-private.com"
  records = [aws_instance.k8s_node02.private_ip]
  ttl     = 300
  type    = "A"
  zone_id = aws_route53_zone._hostedzone_z08420171kozcjn28nk8w.id
}
