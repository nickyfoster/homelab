provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default.token

  # exec {
  #   api_version = "client.authentication.k8s.io/v1beta1"
  #   args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
  #   command     = "aws"
  # }
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.this.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.default.token

    # exec {
    #   api_version = "client.authentication.k8s.io/v1beta1"
    #   args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    #   command     = "aws"
    # }
  }
}
