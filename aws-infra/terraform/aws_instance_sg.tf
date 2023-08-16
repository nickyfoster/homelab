resource "aws_security_group" "private_network" {
  name   = "private_network"
  vpc_id = data.aws_vpc.default_vpc.id

  # ingress {
  #   description = "All connections from bastion SG VPC"

  #   from_port = 0
  #   protocol  = "-1"
  #   to_port   = 0

  #   security_groups = [aws_security_group.bastion.id]
  # }

  ingress {
    description = "All connections from VPC"

    from_port = 0
    protocol  = "-1"
    to_port   = 0

    cidr_blocks = [data.aws_vpc.default_vpc.cidr_block]
  }

  dynamic "ingress" {
    for_each = { for k, v in var.peer_networks : k => v }

    content {
      description = "All connections from ${ingress.value.name}"

      from_port = 0
      protocol  = "-1"
      to_port   = 0

      cidr_blocks = [ingress.value.vpc_cidr]
    }
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private_network"
  }
}
