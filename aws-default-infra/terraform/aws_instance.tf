resource "aws_instance" "private_instance" {
  for_each = { for host in var.private_hosts : host.name => host }


  ami           = lookup(each.value, "ami", data.aws_ami.ubuntu.id)
  instance_type = lookup(each.value, "instance_type", "t3a.micro")


  availability_zone = lookup(each.value, "availability_zone", aws_subnet.subnet[var.availability_zones[1]].availability_zone)
  subnet_id         = lookup(each.value, "subnet_id", aws_subnet.subnet[var.availability_zones[1]].id)

  associate_public_ip_address = true
  key_name                    = lookup(each.value, "key_name", data.aws_key_pair.ssh.key_name)

  vpc_security_group_ids = lookup(each.value, "vpc_security_group_ids", [
    aws_security_group.private_network.id
  ])

  ebs_optimized = true

  root_block_device {
    delete_on_termination = true
    volume_size           = lookup(each.value, "volume_size", 10)
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




resource "aws_instance" "test" {
  for_each = { for host in var._test_private_hosts : host.name => host }

  ami           = lookup(each.value, "ami", null) == null ? "DEFAULT_AMI" : each.value.ami
  instance_type = lookup(each.value, "instance_type", null) == null ? "DEFAULT_INSTANCE_TYPE" : each.value.instance_type

}