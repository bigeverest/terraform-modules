output "role_id" {
  description = "The role's ID"
  value = try(aws_iam_role.this.id, "")
}

output "role_arn" {
  description = "The ARN assigned to role"
  value       = try(aws_iam_role.this.arn, "")
}

