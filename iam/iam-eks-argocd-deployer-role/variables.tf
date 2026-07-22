variable "create_role" {
  description = "Whether to create the IAM policy"
  type        = bool
  default     = true
}

variable "role_name" {
  description = "The name of the role"
  type        = string
  default     = null
}

variable "role_assume_policy" {
  description = "The path of the policy for role to assume"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "create_role_policy" {
  description = "Whether to create the IAM policy"
  type        = bool
  default     = true
}

variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = null
}

variable "policy" {
  description = "The path of the policy in IAM (tpl file)"
  type        = string
  default     = ""
}