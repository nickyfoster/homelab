################################################################################
# Node Group
################################################################################

locals {
  launch_template_name = "launch-template-${var.suffix}"
  security_group_ids   = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}

resource "aws_eks_node_group" "this" {
  cluster_name  = var.cluster_name
  node_role_arn = aws_iam_role.node.arn
  subnet_ids    = aws_subnet.public[*].id

  scaling_config {
    min_size     = var.min_size
    max_size     = var.max_size
    desired_size = var.desired_size
  }

  ami_type        = var.ami_id != "" ? null : var.ami_type
  release_version = var.ami_id != "" ? null : var.ami_release_version
  version         = var.ami_id != "" ? null : var.cluster_version

  capacity_type  = var.capacity_type
  instance_types = var.instance_types

  launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version
  }

  update_config {
    max_unavailable_percentage = var.update_config_max_unavailable_percentage
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      scaling_config[0].desired_size,
    ]
  }

  tags = local.tags
}

resource "aws_launch_template" "this" {
  name = local.launch_template_name

  image_id    = var.ami_id
  description = "Custom launch template for node-group-1 EKS managed node group"

  dynamic "metadata_options" {
    for_each = [var.metadata_options]

    content {
      http_endpoint               = try(metadata_options.value.http_endpoint, null)
      http_put_response_hop_limit = try(metadata_options.value.http_put_response_hop_limit, null)
      http_tokens                 = try(metadata_options.value.http_tokens, null)
    }
  }

  monitoring {
    enabled = var.enable_monitoring
  }

  dynamic "tag_specifications" {
    for_each = toset(var.tag_specifications)

    content {
      resource_type = tag_specifications.key
      tags          = merge(local.tags, { Name = var.node_group_name })
    }
  }

  vpc_security_group_ids = [local.security_group_ids]

  tags = local.tags

  depends_on = [
    aws_iam_role_policy_attachment.node,
  ]

  lifecycle {
    create_before_destroy = true
  }
}