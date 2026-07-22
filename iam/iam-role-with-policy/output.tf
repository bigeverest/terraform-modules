output "role_id" {
  description = "The role's ID"
  value = try(aws_iam_role.this.id, "")
}

output "role_arn" {
  description = "The ARN assigned to role"
  value       = try(aws_iam_role.this.arn, "")
}

output "policy_id" {
  description = "The policies ID"
  value = try(aws_iam_role_policy.this.id, "")
}

output "policy_name" {
  description = "The policies name"
  value = try(aws_iam_role_policy.this.name, "")
}

output "policy" {
  description = "The policies policy"
  value = try(aws_iam_role_policy.this.policy, "")
}
