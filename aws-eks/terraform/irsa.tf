################################################################################
# IRSA
################################################################################

data "tls_certificate" "this" {
  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "oidc_provider" {
  url = aws_eks_cluster.this.identity[0].oidc[0].issuer

  client_id_list  = ["sts.${local.dns_suffix}"]
  thumbprint_list = data.tls_certificate.this.certificates[*].sha1_fingerprint

  tags = local.tags
}

