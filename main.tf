locals {
  default_tags = {
    Terraform   = "true"
    Environment = "production"
  }
}

variable "host_count" {
  type        = number
  default     = 1
  description = "Number of dedicated hosts to create."
}

variable "auto_placement" {
  type        = string
  default     = "on"
  description = "Whether to enable auto placement for the dedicated host."
}

variable "availability_zone" {
  type        = string
  default     = "us-east-1a"
  description = "The availability zone to launch the dedicated host in."
}

variable "host_recovery" {
  type        = string
  default     = "on"
  description = "Whether to enable host recovery for the dedicated host."
}

variable "instance_type" {
  type        = string
  default     = "c4.large"
  description = "The instance type to use for the dedicated host."
}

variable "additional_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to the dedicated host."
}

resource "aws_ec2_host" "this" {
  count = var.host_count

  auto_placement    = var.auto_placement
  availability_zone = var.availability_zone
  host_recovery     = var.host_recovery
  instance_type     = var.instance_type
  tags              = merge(local.default_tags, var.additional_tags)
}

output "dedicated_host_ids" {
  value       = aws_ec2_host.this[*].id
  description = "The IDs of the AWS Dedicated Hosts."
}
