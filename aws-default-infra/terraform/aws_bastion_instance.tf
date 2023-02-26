resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3a.micro"

  availability_zone = aws_subnet.subnet[var.availability_zones[1]].availability_zone
  subnet_id         = aws_subnet.subnet[var.availability_zones[1]].id

  associate_public_ip_address = true
  key_name                    = data.aws_key_pair.ssh.key_name

  vpc_security_group_ids = [
    aws_security_group.bastion.id
  ]

  ebs_optimized = true

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
  }

  lifecycle {
    ignore_changes = [
      ami,
      user_data,
      user_data_base64,
    ]

    replace_triggered_by = [
      null_resource.recreate
    ]
  }

  tags = {
    Name = "bastion"
  }
}

# Lever for recreating EC2 instance
# When hard reset is needed => flip the switch!
resource "null_resource" "recreate" {
  triggers = {
    switch_is_on = false
  }
}
