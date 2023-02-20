data "aws_iam_policy_document" "lb_controller_assume" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.oidc_provider.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_eks_cluster.this.identity[0].oidc[0].issuer, "https://", "")}:sub"

      values = [
        "system:serviceaccount:${var.alb_namespace}:${var.alb_service_account_name}",
      ]
    }

    effect = "Allow"
  }
}

resource "aws_iam_policy" "lb_controller" {
  name        = "${var.cluster_name}-alb-ingress"
  path        = "/"
  description = "Policy for alb-ingress service"

  policy = file("templates/AWSLoadBalancerControllerIAMPolicy.json")
}

resource "aws_iam_role" "lb_controller" {
  name               = "${var.cluster_name}-alb-ingress"
  assume_role_policy = data.aws_iam_policy_document.lb_controller_assume.json
}

resource "aws_iam_role_policy_attachment" "lb_controller" {
  role       = aws_iam_role.lb_controller.name
  policy_arn = aws_iam_policy.lb_controller.arn
}

resource "helm_release" "lb_controller" {
  name       = var.alb_helm_chart_name
  chart      = var.alb_helm_chart_release_name
  repository = var.alb_helm_chart_repo
  version    = var.alb_helm_chart_version
  namespace  = var.alb_namespace

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = var.alb_service_account_name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.lb_controller.arn
  }
  depends_on = [
    aws_eks_node_group.this
  ]
}