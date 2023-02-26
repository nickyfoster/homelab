resource "aws_vpc" "vpc" {
  cidr_block = var.k8s_vpc_cidr_block

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    # "kubernetes.io/cluster/${var.name}" = "owned",
    Name = "k8s"
  }
}

resource "aws_internet_gateway" "vpc" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "gateway"
  }
}

resource "aws_default_route_table" "vpc" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  tags = {
    Name = "k8s-default"
  }
}

resource "aws_route" "vpc_ipv4" {
  route_table_id         = aws_default_route_table.vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc.id
}

resource "aws_route" "vpc_peering" {
  route_table_id            = aws_default_route_table.vpc.id
  destination_cidr_block    = var.default_vpc_cidr_block
  vpc_peering_connection_id = var.peering_conn_id
}