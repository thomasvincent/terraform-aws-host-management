################################################################################
# AWS Dedicated Host Outputs
################################################################################

output "dedicated_host_ids" {
  value       = aws_ec2_host.this[*].id
  description = "The IDs of the AWS Dedicated Hosts."
}

output "dedicated_host_arns" {
  value       = aws_ec2_host.this[*].arn
  description = "The ARNs of the AWS Dedicated Hosts."
}

output "dedicated_host_availability_zones" {
  value       = aws_ec2_host.this[*].availability_zone
  description = "The availability zones of the AWS Dedicated Hosts."
}

output "dedicated_host_owner_ids" {
  value       = aws_ec2_host.this[*].owner_id
  description = "The AWS account IDs of the Dedicated Host owners."
}

output "host_count" {
  value       = var.host_count
  description = "The number of dedicated hosts created."
}

output "instance_type" {
  value       = var.instance_type
  description = "The instance type configured for the dedicated hosts."
}
