locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
}

resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = merge(
    { "Name" = "vpc-${var.suffix}" },
    local.tags
  )
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    { "Name" = "gw-${var.suffix}" },
    local.tags
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    { "Name" = "route-table-${var.suffix}" },
    local.tags
  )
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = element(concat(var.public_subnets, [""]), count.index)
  availability_zone       = element(local.azs, count.index)
  map_public_ip_on_launch = true

  tags = merge(
    { "Name" = "subnet-${var.suffix}-${count.index}" },
    { "kubernetes.io/role/elb" = 1 },
    local.tags
  )
}


# One or more Amazon EC2 Subnets of [subnet-07cbff3f56da0ff92, subnet-01c47a365144843ed] for node group 
# test does not automatically assign public IP addresses to instances launched into it. 
# If you want your instances to be assigned a public IP address, then you need to enable 
# auto-assign public IP address for the subnet. See IP addressing in VPC guide: 
# https://docs.aws.amazon.com/vpc/latest/userguide/vpc-ip-addressing.html#subnet-public-ip