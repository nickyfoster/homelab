region             = "us-east-2"
default_vpc_id     = "vpc-67b2050c"
availability_zones = ["us-east-2a", "us-east-2b"]
private_zone_name  = "mrf0str.internal"
versions = {
  ubuntu = "jammy"
}
ec2_iam_default_profile_statements = [
  {
    name      = "default"
    effect    = "Deny"
    resources = ["*"]
    actions   = ["*"]
  }
]


##################################
###### PRIVATE HOSTS & VPCs ######
##################################
# editable section

peer_networks = [
  {
    name     = "k8s"
    vpc_id   = "vpc-0270503e6888b235d"
    vpc_cidr = "10.10.0.0/16"
  }
]

private_hosts = [
  {
    name = "redis"
    iam = [
      {
        name      = "AllObjectActionsInBackupBucket"
        resources = ["arn:aws:s3:::redis-backups-229/*"]
        actions = [
          "s3:*Object"
        ]
        effect = "Allow"
      }
    ]
  },
  {
    name          = "cointracker"
    instance_type = "t3a.micro"
    iam = [
      {
        name      = "ReadECRallRepos"
        resources = ["*"]
        actions = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:GetLifecyclePolicy",
          "ecr:GetLifecyclePolicyPreview",
          "ecr:ListTagsForResource",
          "ecr:DescribeImageScanFindings"
        ]
        effect = "Allow"
      }
    ]
  }
]
