resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = var.role_assume_policy
  tags               = var.tags
}
