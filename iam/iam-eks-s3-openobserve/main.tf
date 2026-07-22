locals {
  role_name              = var.role_name
  policy_name            = var.policy_name
  oidc_provider          = var.oidc_provider
  oidc_provider_arn      = var.oidc_provider_arn
  openobserve_bucket_arn = var.openobserve_bucket_arn
  tags                   = var.tags
}


data "aws_iam_policy_document" "aws_s3_openobserve_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

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

resource "aws_iam_role" "aws_s3_openobserve" {
  assume_role_policy = data.aws_iam_policy_document.aws_s3_openobserve_assume_role_policy.json
  name               = local.role_name

  tags = local.tags

}

resource "aws_iam_policy" "aws_s3_openobserve" {
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "OpenObserveStorage",
          "Effect" : "Allow",
          "Action" : [
            "s3:ListBucket",
            "s3:PutObject",
            "s3:GetObject",
            "s3:DeleteObject"
          ],
          "Resource" : [
            "${local.openobserve_bucket_arn}",
            "${local.openobserve_bucket_arn}/*"
          ]
        }
      ]
    }
  )
  name = local.policy_name

  tags = local.tags

}

resource "aws_iam_role_policy_attachment" "aws_s3_openobserve_attach" {
  role       = aws_iam_role.aws_s3_openobserve.name
  policy_arn = aws_iam_policy.aws_s3_openobserve.arn
}
