data "aws_vpc" "default_vpc" {
  id = var.default_vpc_id
}

resource "aws_vpc_peering_connection" "vpc_peerings" {
  for_each = { for k, v in var.peer_networks : k => v }

  vpc_id      = data.aws_vpc.default_vpc.id
  peer_vpc_id = each.value.vpc_id

  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name = "VPC ${each.value.name} to default"
  }
}

resource "aws_route" "vpc_peering" {
  for_each = { for k, v in var.peer_networks : k => v }

  route_table_id            = data.aws_vpc.default_vpc.main_route_table_id
  destination_cidr_block    = each.value.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peerings[each.key].id
}
