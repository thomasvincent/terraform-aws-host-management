################################################################################
# Basic Example - AWS Dedicated Hosts
################################################################################

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "dedicated_hosts" {
  source = "../../"

  host_count        = 2
  availability_zone = "us-east-1a"
  instance_type     = "c5.large"
  auto_placement    = "on"
  host_recovery     = "on"

  environment = "production"
  project     = "example-app"
  owner       = "platform-team"

  additional_tags = {
    CostCenter  = "engineering"
    Application = "example"
  }
}

output "host_ids" {
  description = "IDs of the created dedicated hosts"
  value       = module.dedicated_hosts.dedicated_host_ids
}

output "host_arns" {
  description = "ARNs of the created dedicated hosts"
  value       = module.dedicated_hosts.dedicated_host_arns
}
