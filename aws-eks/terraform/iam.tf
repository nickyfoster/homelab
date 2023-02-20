################################################################################
# IAM
################################################################################

locals {
  iam_role_policy_prefix = "arn:${local.partition}:iam::aws:policy"
}

data "aws_iam_policy_document" "assume_role_policy_cluster" {
  count = 1
  statement {
    sid     = "EKSClusterAssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.${local.dns_suffix}", "ec2.${local.dns_suffix}"]
    }
  }
}

resource "aws_iam_policy" "cluster_encryption" {
  name = var.cluster_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ListGrants",
          "kms:DescribeKey",
        ]
        Effect   = "Allow"
        Resource = module.kms.key_arn
      },
    ]
  })
  tags = local.tags
}

resource "aws_iam_role" "cluster" {
  name = "cluster-role-${var.suffix}"

  assume_role_policy    = data.aws_iam_policy_document.assume_role_policy_cluster[0].json
  force_detach_policies = true

  # Fix log group recreate during infra destruction
  inline_policy {
    name = var.cluster_name

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["logs:CreateLogGroup"]
          Effect   = "Deny"
          Resource = "*"
        },
      ]
    })
  }
  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "cluster_encryption" {
  policy_arn = aws_iam_policy.cluster_encryption.arn
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role_policy_attachment" "cluster" {
  for_each = { for k, v in {
    AmazonEKSClusterPolicy         = "${local.iam_role_policy_prefix}/AmazonEKSClusterPolicy",
    AmazonEKSVPCResourceController = "${local.iam_role_policy_prefix}/AmazonEKSVPCResourceController",
  } : k => v }

  policy_arn = each.value
  role       = aws_iam_role.cluster.name
}

data "aws_iam_policy_document" "assume_role_policy_node" {
  statement {
    sid     = "EKSNodeAssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.${local.dns_suffix}"]
    }
  }
}

resource "aws_iam_role" "node" {
  name                  = "node-role-${var.suffix}"
  assume_role_policy    = data.aws_iam_policy_document.assume_role_policy_node.json
  force_detach_policies = true

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "node" {
  for_each = { for k, v in toset(compact([
    "${local.iam_role_policy_prefix}/AmazonEKSWorkerNodePolicy",
    "${local.iam_role_policy_prefix}/AmazonEC2ContainerRegistryReadOnly",
    "${local.iam_role_policy_prefix}/AmazonEKS_CNI_Policy"
  ])) : k => v }

  policy_arn = each.value
  role       = aws_iam_role.node.name
}

