locals {
  role_name         = var.role_name
  policy_name       = var.policy_name
  oidc_provider     = var.oidc_provider
  oidc_provider_arn = var.oidc_provider_arn
  tags              = var.tags
}


data "aws_iam_policy_document" "argocd_manager_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(local.oidc_provider, "https://", "")}:sub"
      values = ["system:serviceaccount:gitops:argocd-application-controller",
        "system:serviceaccount:gitops:argocd-applicationset-controller",
      "system:serviceaccount:gitops:argocd-server"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(local.oidc_provider, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    principals {
      identifiers = [local.oidc_provider_arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "argocd_manager" {
  assume_role_policy = data.aws_iam_policy_document.argocd_manager_assume_role_policy.json
  name               = local.role_name

  tags = local.tags

}

resource "aws_iam_policy" "argocd_manager_permissions" {
  policy = var.policy
  name   = local.policy_name

  tags = local.tags

}

resource "aws_iam_role_policy_attachment" "argocd_manager_permissions_attach" {
  role       = aws_iam_role.argocd_manager.name
  policy_arn = aws_iam_policy.argocd_manager_permissions.arn
}
