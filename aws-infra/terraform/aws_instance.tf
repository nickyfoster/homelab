resource "aws_instance" "private_instance" {
  for_each = { for host in var.private_hosts : host.name => host }


  ami           = lookup(each.value, "ami", null) == null ? data.aws_ami.ubuntu.id : each.value.ami
  instance_type = lookup(each.value, "instance_type", null) == null ? "t3a.micro" : each.value.instance_type


  availability_zone = lookup(each.value, "availability_zone", null) == null ? aws_subnet.subnet[var.availability_zones[1]].availability_zone : each.value.availability_zone

  subnet_id = lookup(each.value, "subnet_id", null) == null ? aws_subnet.subnet[var.availability_zones[1]].id : each.value.subnet_id

  associate_public_ip_address = true
  key_name                    = lookup(each.value, "key_name", null) == null ? data.aws_key_pair.ssh.key_name : each.value.key_name

  vpc_security_group_ids = lookup(each.value, "vpc_security_group_ids", null) == null ? [
    aws_security_group.private_network.id
  ] : each.value.vpc_security_group_ids


  iam_instance_profile = aws_iam_instance_profile.instance_profile[each.key].name


  ebs_optimized = true

  root_block_device {
    delete_on_termination = true
    volume_size           = lookup(each.value, "volume_size", null) == null ? 10 : each.value.volume_size
  }

  lifecycle {
    ignore_changes = [
      ami,
      user_data,
      user_data_base64,
    ]
  }

  tags = {
    Name = each.key
  }
}
