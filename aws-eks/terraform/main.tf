data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

data "aws_eks_cluster_auth" "default" {
  name = var.cluster_name
}

locals {
  cluster_name = "eks-epam-test"

  dns_suffix = data.aws_partition.current.dns_suffix
  partition  = data.aws_partition.current.partition
  account_id = data.aws_caller_identity.current.account_id # TODO delete

  tags = {
    terraform_managed = 1
  }
}