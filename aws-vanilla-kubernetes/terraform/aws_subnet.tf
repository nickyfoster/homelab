resource "aws_subnet" "subnet" {
  for_each = { for k, v in var.availability_zones : v => k }

  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.key

  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 0 + each.value)

  map_public_ip_on_launch = true

  tags = {
    # "kubernetes.io/cluster/${var.name}" = "owned"
    Name = "k8s-${each.key}"
  }
}
