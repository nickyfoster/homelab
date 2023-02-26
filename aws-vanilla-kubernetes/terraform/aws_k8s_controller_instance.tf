# resource "aws_instance" "k8s_controller" {

#   ami               = data.aws_ami.ubuntu.id
#   instance_type     = var.k8s_controller_instance_type
#   availability_zone = element(var.availability_zones, 1)
#   subnet_id         = aws_subnet.subnet[var.availability_zones[1]].id

#   associate_public_ip_address = true
#   key_name                    = data.aws_key_pair.ssh.key_name

#   iam_instance_profile = aws_iam_instance_profile.controller.name

#   vpc_security_group_ids = [
#     aws_security_group.controller.id
#   ]

#   # vpc_security_group_ids = [
#   #   aws_security_group.controller.id,
#   #   aws_security_group.worker.id
#   # ]

#   ebs_optimized = true

#   # user_data = data.cloudinit_config.controller.rendered

#   root_block_device {
#     delete_on_termination = true
#     volume_size           = 50
#   }

#   lifecycle {
#     ignore_changes = [
#       ami,
#       user_data,
#       user_data_base64,
#     ]
#   }
#   tags = {
#     Name = "k8s-controller"
#     # "kubernetes.io/cluster/${var.name}" = "owned"

#   }
# }
