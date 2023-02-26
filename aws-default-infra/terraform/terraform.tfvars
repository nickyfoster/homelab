region = "us-east-2"

default_vpc_id = "vpc-67b2050c"

availability_zones = ["us-east-2a", "us-east-2b"]

versions = {
  ubuntu = "jammy"
}

peer_networks = [{
  name     = "k8s"
  vpc_id   = "vpc-0270503e6888b235d"
  vpc_cidr = "10.10.0.0/16"
}]

ec2_iam_default_profile_statements = [
  {
    name      = "default"
    resources = ["*"]
    actions   = [""]
  }
]

###### PRIVATE HOSTS ######
private_hosts = [
  {
    name = "redis"
    iam = [
      {
        name      = "test"
        resources = ["*"]
        actions   = ["s3:delete", "ec2:block"]
      }
    ]
  },
  {
    name          = "cointracker"
    instance_type = "t3a.micro"
  },
]


_test_private_hosts = [
  {
    name          = "redis"
    instance_type = "t2.micro"
    iam = [
      { 
        name = "DEMO_tmp_var"
        resources = ["*"],
        actions = ["s3:delete", "ec2:block"]
      }
    ]
  },
  {
    name          = "cointracker"
    instance_type = "t3a.micro"
  }
]