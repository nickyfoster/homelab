# resource "aws_eks_addon" "kube-proxy" {
#   depends_on     = [aws_eks_node_group.ng1]
#   cluster_name = data.aws_eks_cluster.eks_cluster.name
#   addon_name   = "kube-proxy"
# }

# resource "aws_eks_addon" "coredns" {
#   depends_on     = [aws_eks_node_group.ng1]
#   cluster_name = data.aws_eks_cluster.eks_cluster.name
#   addon_name   = "coredns"
# }

# module "external_dns_helm" {
#   source = "lablabs/eks-external-dns/aws"

#   cluster_identity_oidc_issuer     = module.eks.cluster_oidc_issuer_url
#   cluster_identity_oidc_issuer_arn = module.eks.oidc_provider_arn
# }

# TODO Warning: "default_secret_name" is no longer applicable for Kubernetes v1.24.0 and above
# TODO external DNS does not delete CNAME and TXT records from Route 53