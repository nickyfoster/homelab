
resource "aws_security_group" "all_ports_internal" {
  tags = {
    Name = "all-ports-internal"
  }

  tags_all = {
    Name = "all-ports-internal"
  }

  description = "Allos all ports from inside VPC"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["172.31.0.0/16"]
    description = "All traffic inside VPC"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  name   = "default-sg-vpc-internal"
  vpc_id = aws_vpc.eu_east_main_vnet.id
}

resource "aws_security_group" "default_all" {
  tags = {
    Name = "default-all"
  }

  tags_all = {
    Name = "default-all"
  }

  description = "default VPC security group"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    from_port = 0
    protocol  = "-1"
    self      = true
    to_port   = 0
  }

  name   = aws_vpc.eu_east_main_vnet.instance_tenancy
  vpc_id = "vpc-67b2050c"
}

resource "aws_security_group" "http_s_internet" {
  tags = {
    Name = "http-s-internet"
  }

  tags_all = {
    Name = "http-s-internet"
  }

  description = "Allow HTTP(S) from Internet"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS"
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }

  name   = "http-https-from-internet"
  vpc_id = aws_vpc.eu_east_main_vnet.id
}

resource "aws_security_group" "ovpn_client_internet" {
  tags = {
    Name = "ovpn-client-internet"
  }

  tags_all = {
    Name = "ovpn-client-internet"
  }

  description = "Allow client access to Openvpn server"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Openvpn client connections"
    from_port   = 1194
    protocol    = "udp"
    to_port     = 1194
  }

  name   = "openvpn-client-access"
  vpc_id = aws_vpc.eu_east_main_vnet.id
}

resource "aws_security_group" "ssh_internet" {
  tags = {
    Name = "ssh-internet"
  }

  tags_all = {
    Name = "ssh-internet"
  }

  description = "Allow SSH from Internet"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  name   = "default-sg-ssh"
  vpc_id = aws_vpc.eu_east_main_vnet.id
}

resource "aws_security_group" "k8s_network" {
  tags = {
    Name = "k8s-network"
  }

  tags_all = {
    Name = "k8s-network"
  }

  description = "Allow k8s traffic"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["10.32.0.0/12"]
    description = "k8s cluster cidr"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  # ingress {
  #   cidr_blocks = ["10.96.0.0/12"]
  #   description = "k8s cluster svc"
  #   from_port   = 0
  #   protocol    = "-1"
  #   to_port     = 0
  # }

  name   = "k8s-network"
  vpc_id = aws_vpc.eu_east_main_vnet.id
}
