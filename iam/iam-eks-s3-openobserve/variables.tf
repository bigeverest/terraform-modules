variable "role_name" {
  description = "The name of the role"
  type        = string
}

variable "policy_name" {
  description = "The name of the policy"
  type        = string
}

variable "oidc_provider" {
  description = "OIDC provider"
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDC provider ARN"
  type        = string
}

variable "openobserve_bucket_arn" {
  description = "The bucket arn for open observe"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
