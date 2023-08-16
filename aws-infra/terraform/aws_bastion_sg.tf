# resource "aws_security_group" "bastion" {
#   name   = "bastion"
#   vpc_id = data.aws_vpc.default_vpc.id

#   ingress {
#     description = "ICMP"

#     from_port = -1
#     protocol  = "icmp"
#     to_port   = -1

#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "SSH"

#     from_port = 22
#     protocol  = "tcp"
#     to_port   = 22

#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "Wireguard peer connections"

#     from_port = 51820
#     protocol  = "udp"
#     to_port   = 51820

#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port = 0
#     protocol  = "-1"
#     to_port   = 0

#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "bastion"
#   }
# }
