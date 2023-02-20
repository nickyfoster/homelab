resource "aws_iam_instance_profile" "k8s_node_profile" {
  name = "k8s_node_profile"
  role = data.aws_iam_role.ec2-ecr-puller.id
}

data "aws_iam_role" "ec2-ecr-puller" {
  name = "ec2-ecr-puller"
}