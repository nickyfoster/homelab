resource "aws_instance" "k8s_controller" {
  tags = {
    Name = "k8s-controller"
  }

  tags_all = {
    Name = "k8s-controller"
  }

  ami                         = var.k8s_instance_ami
  associate_public_ip_address = true
  availability_zone           = "us-east-2c"
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = var.k8s_instance_type
  key_name                             = aws_key_pair.aws_ec2_hosts.id
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  private_ip = "172.31.39.1"
  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp2"
  }

  source_dest_check      = true
  subnet_id              = aws_subnet.sandbox.id
  tenancy                = aws_vpc.eu_east_main_vnet.instance_tenancy
  vpc_security_group_ids = [aws_security_group.all_ports_internal.id, aws_security_group.ssh_internet.id, aws_security_group.k8s_network.id]
}


resource "aws_instance" "k8s_node01" {
  tags = {
    Name = "k8s-node01"
  }

  tags_all = {
    Name = "k8s-node01"
  }

  ami                         = var.k8s_instance_ami
  associate_public_ip_address = true
  availability_zone           = "us-east-2c"
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = var.k8s_instance_type
  key_name                             = aws_key_pair.aws_ec2_hosts.id
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  private_ip = "172.31.39.2"
  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp2"
  }

  source_dest_check      = true
  subnet_id              = aws_subnet.sandbox.id
  tenancy                = aws_vpc.eu_east_main_vnet.instance_tenancy
  vpc_security_group_ids = [aws_security_group.all_ports_internal.id, aws_security_group.ssh_internet.id, aws_security_group.k8s_network.id]
  iam_instance_profile   = aws_iam_instance_profile.k8s_node_profile.id

}

resource "aws_instance" "k8s_node02" {
  tags = {
    Name = "k8s-node02"
  }

  tags_all = {
    Name = "k8s-node02"
  }

  ami                         = var.k8s_instance_ami
  associate_public_ip_address = true
  availability_zone           = "us-east-2c"
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = var.k8s_instance_type
  key_name                             = aws_key_pair.aws_ec2_hosts.id
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  private_ip = "172.31.39.3"
  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp2"
  }

  source_dest_check      = true
  subnet_id              = aws_subnet.sandbox.id
  tenancy                = aws_vpc.eu_east_main_vnet.instance_tenancy
  vpc_security_group_ids = [aws_security_group.all_ports_internal.id, aws_security_group.ssh_internet.id, aws_security_group.k8s_network.id]
  iam_instance_profile   = aws_iam_instance_profile.k8s_node_profile.id
}
