################################################################################
# AWS Dedicated Host Management
# Terraform module for provisioning and managing AWS EC2 Dedicated Hosts
################################################################################

locals {
  default_tags = {
    Terraform   = "true"
    Environment = var.environment
    Project     = var.project
    Owner       = var.owner
    ManagedBy   = "terraform-aws-host-management"
  }

  # Filter out empty tags
  filtered_tags = { for k, v in local.default_tags : k => v if v != "" }

  # Merge default tags with additional tags
  all_tags = merge(local.filtered_tags, var.additional_tags)
}

################################################################################
# EC2 Dedicated Host Resource
################################################################################

resource "aws_ec2_host" "this" {
  count = var.host_count

  auto_placement    = var.auto_placement
  availability_zone = var.availability_zone
  host_recovery     = var.host_recovery

  # Use instance_type or instance_family (mutually exclusive)
  instance_type   = var.instance_family == null ? var.instance_type : null
  instance_family = var.instance_family

  # Optional Outpost configuration
  outpost_arn = var.outpost_arn
  asset_id    = var.asset_id

  tags = merge(
    local.all_tags,
    {
      Name = var.host_count > 1 ? "${var.project}-dedicated-host-${count.index + 1}" : "${var.project}-dedicated-host"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}
