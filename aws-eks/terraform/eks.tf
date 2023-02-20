################################################################################
# Cluster
################################################################################

locals {
  cluster_role = aws_iam_role.cluster.arn
}

resource "aws_eks_cluster" "this" {
  name                      = var.cluster_name
  role_arn                  = local.cluster_role
  version                   = var.cluster_version
  enabled_cluster_log_types = var.cluster_enabled_log_types

  vpc_config {
    subnet_ids = aws_subnet.public[*].id
  }

  tags = local.tags

  depends_on = [
    aws_iam_role_policy_attachment.cluster,
    aws_security_group_rule.cluster,
    aws_security_group_rule.node,
    aws_cloudwatch_log_group.this
  ]
}

resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/eks/${var.cluster_name}/cluster"

  tags = local.tags
}
