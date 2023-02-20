resource "aws_key_pair" "aws_ec2_hosts" {
  key_name   = "aws-ec2-hosts"
  public_key = ""
}


resource "aws_instance" "cointracker" {
  tags = {
    Name = "cointracker"
  }

  tags_all = {
    Name = "cointracker"
  }

  ami                         = "ami-0283a57753b18025b"
  associate_public_ip_address = true
  availability_zone           = "us-east-2a"
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  key_name                             = aws_key_pair.aws_ec2_hosts.id
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  private_ip = "172.31.1.132"
  root_block_device {
    delete_on_termination = true
    volume_size           = 8
    volume_type           = "gp2"
  }

  source_dest_check      = true
  subnet_id              = aws_subnet.aws_infra.id
  tenancy                = aws_vpc.eu_east_main_vnet.instance_tenancy
  vpc_security_group_ids = [aws_security_group.all_ports_internal.id, aws_security_group.ssh_internet.id]
}

resource "aws_instance" "hashtopolis_server" {
  tags = {
    Name = "hashtopolis-server"
  }

  tags_all = {
    Name = "hashtopolis-server"
  }

  ami                         = "ami-00eeedc4036573771"
  associate_public_ip_address = true
  availability_zone           = "us-east-2c"
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  key_name                             = aws_key_pair.aws_ec2_hosts.id
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  private_ip = "172.31.39.185"
  root_block_device {
    delete_on_termination = true
    volume_size           = 8
    volume_type           = "gp2"
  }

  source_dest_check      = true
  subnet_id              = aws_subnet.sandbox.id
  tenancy                = aws_vpc.eu_east_main_vnet.instance_tenancy
  vpc_security_group_ids = [aws_security_group.all_ports_internal.id, aws_security_group.ssh_internet.id]
}

resource "aws_instance" "infra" {
  tags = {
    Name = "infra"
  }

  tags_all = {
    Name = "infra"
  }

  ami                         = "ami-0fb653ca2d3203ac1"
  associate_public_ip_address = true
  availability_zone           = "us-east-2a"
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  key_name                             = aws_key_pair.aws_ec2_hosts.id
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  private_ip = "172.31.2.36"
  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp2"
  }

  source_dest_check      = true
  subnet_id              = "subnet-6a3ee101"
  tenancy                = aws_vpc.eu_east_main_vnet.instance_tenancy
  vpc_security_group_ids = [aws_security_group.all_ports_internal.id, aws_security_group.ssh_internet.id]
}

resource "aws_instance" "openvpn_server" {
  tags = {
    Name = "openvpn-server"
  }

  tags_all = {
    Name = "openvpn-server"
  }

  ami                         = "ami-00eeedc4036573771"
  associate_public_ip_address = true
  availability_zone           = "us-east-2c"
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  key_name                             = aws_key_pair.aws_ec2_hosts.id
  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  private_ip = "172.31.37.194"
  root_block_device {
    delete_on_termination = true
    volume_size           = 15
    volume_type           = "gp2"
  }

  source_dest_check      = true
  subnet_id              = aws_subnet.sandbox.id
  tenancy                = aws_vpc.eu_east_main_vnet.instance_tenancy
  vpc_security_group_ids = [aws_security_group.http_s_internet.id, aws_security_group.all_ports_internal.id, aws_security_group.ovpn_client_internet.id, aws_security_group.ssh_internet.id]
}