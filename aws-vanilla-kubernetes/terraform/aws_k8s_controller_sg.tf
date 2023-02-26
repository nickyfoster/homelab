resource "aws_security_group" "controller" {
  name   = "controller"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "All connections from default VPC"

    from_port = 0
    protocol  = "-1"
    to_port   = 0

    cidr_blocks = [var.default_vpc_cidr_block]
    # security_groups = [aws_security_group.bastion.id]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "controller"
  }
}
