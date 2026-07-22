locals {
  role_name = var.role_name
  policy_name = var.policy_name
  oidc_provider = var.oidc_provider
  oidc_provider_arn = var.oidc_provider_arn
  tags = var.tags
}


data "aws_iam_policy_document" "aws_asg_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(local.oidc_provider, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:cluster-autoscaler-sa"]
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

resource "aws_iam_role" "aws_asg" {
  assume_role_policy = data.aws_iam_policy_document.aws_asg_assume_role_policy.json
  name               = local.role_name

  tags = local.tags

}

resource "aws_iam_policy" "aws_asg" {
  policy = file("./iam-asg-policy.json")
  name   = local.policy_name
  
  tags = local.tags

}

resource "aws_iam_role_policy_attachment" "aws_asg_attach" {
  role       = aws_iam_role.aws_asg.name
  policy_arn = aws_iam_policy.aws_asg.arn
}

