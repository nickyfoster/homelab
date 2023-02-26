data "aws_iam_policy_document" "assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    effect = "Allow"
  }
}


# LEGACY below
# resource "aws_iam_instance_profile" "k8s_node_profile" {
#   name = "k8s_node_profile"
#   role = data.aws_iam_role.ec2-ecr-puller.id
# }

# data "aws_iam_role" "ec2-ecr-puller" {
#   name = "ec2-ecr-puller"
# }