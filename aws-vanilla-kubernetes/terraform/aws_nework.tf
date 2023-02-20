resource "aws_eip" "redis" {
  tags = {
    Name = "redis"
  }

  tags_all = {
    Name = "redis"
  }

  instance             = "i-0b81d0055ab6179ad"
  network_border_group = var.region
  network_interface    = "eni-09f10cf7118d36ed6"
  public_ipv4_pool     = "amazon"
  vpc                  = true
}

resource "aws_eip" "mrf0str_infra_server" {
  tags = {
    Name = "mrf0str-infra-server"
  }

  tags_all = {
    Name = "mrf0str-infra-server"
  }

  instance             = "i-050720052ceed6bb2"
  network_border_group = var.region
  network_interface    = aws_instance.infra.primary_network_interface_id
  public_ipv4_pool     = "amazon"
  vpc                  = true
}

resource "aws_eip" "openvpn_server" {
  tags = {
    Name = "openvpn-server"
  }

  tags_all = {
    Name = "openvpn-server"
  }

  instance             = "i-0ba8770bad14c070c"
  network_border_group = var.region
  network_interface    = "eni-0b9bba1930dd27b5f"
  public_ipv4_pool     = "amazon"
  vpc                  = true
}

resource "aws_eip" "k8s_controller" {
  tags = {
    Name = "k8s_controller"
  }

  tags_all = {
    Name = "k8s_controller"
  }

  instance             = aws_instance.k8s_controller.id
  network_border_group = var.region
  vpc                  = true
}

resource "aws_internet_gateway" "igw_58de8f30" {
  vpc_id = aws_vpc.eu_east_main_vnet.id
}

resource "aws_route_table" "rtb_91ef93fa" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_58de8f30.id
  }

  vpc_id = aws_vpc.eu_east_main_vnet.id
}


resource "aws_subnet" "aws_infra" {
  tags = {
    Name = "aws-infra"
  }

  tags_all = {
    Name = "aws-infra"
  }

  availability_zone                   = "us-east-2a"
  cidr_block                          = "172.31.0.0/20"
  map_public_ip_on_launch             = true
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = aws_vpc.eu_east_main_vnet.id
}

resource "aws_subnet" "sandbox" {
  tags = {
    Name                     = "sandbox"
    "kubernetes.io/role/elb" = "1"
  }

  tags_all = {
    Name                     = "sandbox"
    "kubernetes.io/role/elb" = "1"
  }

  availability_zone                   = "us-east-2c"
  cidr_block                          = "172.31.32.0/20"
  map_public_ip_on_launch             = true
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = aws_vpc.eu_east_main_vnet.id
}

resource "aws_subnet" "subnet_e79e8b9d" {
  tags = {
    "kubernetes.io/role/elb" = "1"
  }

  tags_all = {
    "kubernetes.io/role/elb" = "1"
  }

  availability_zone                   = "us-east-2b"
  cidr_block                          = "172.31.16.0/20"
  map_public_ip_on_launch             = true
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = aws_vpc.eu_east_main_vnet.id
}

resource "aws_vpc" "eu_east_main_vnet" {
  tags = {
    Name = "eu-east-main-vnet"
  }

  tags_all = {
    Name = "eu-east-main-vnet"
  }

  cidr_block           = "172.31.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
}
