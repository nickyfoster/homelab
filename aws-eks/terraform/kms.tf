module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "1.1.0"

  aliases               = ["eks/${var.suffix}"]
  description           = "${var.cluster_name} cluster encryption key"
  enable_default_policy = true
  key_owners            = [data.aws_caller_identity.current.arn]

  tags = local.tags
}