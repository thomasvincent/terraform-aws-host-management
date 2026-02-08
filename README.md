# terraform-aws-host-management

OpenTofu module for provisioning and managing AWS EC2 Dedicated Hosts.

[![OpenTofu CI](https://github.com/thomasvincent/terraform-aws-host-management/actions/workflows/terraform-ci.yml/badge.svg)](https://github.com/thomasvincent/terraform-aws-host-management/actions/workflows/terraform-ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![OpenTofu](https://img.shields.io/badge/OpenTofu-%3E%3D1.6.0-blue)](https://opentofu.org/)

> **Note**: This module has been migrated from Terraform to [OpenTofu](https://opentofu.org/), the open-source fork of Terraform. OpenTofu is a drop-in replacement and is fully compatible with existing Terraform configurations.

## Architecture

Provisions multiple AWS EC2 Dedicated Hosts with configurable instance types, auto-placement, and host recovery. Supports AWS Outposts for hybrid deployments and comprehensive tagging with validation.

## Prerequisites

- OpenTofu >= 1.6.0 (or Terraform >= 1.0.0)
- AWS Provider >= 5.0.0
- Valid AWS credentials configured
- Appropriate IAM permissions for EC2 Dedicated Hosts

## Quick Start

```bash
# Initialize
terraform init

# Review planned changes
terraform plan

# Apply configuration
terraform apply
```

## Module Structure

- `main.tf` - Dedicated host resource definitions
- `variables.tf` - Input variables with validation rules
- `outputs.tf` - Output value definitions
- `versions.tf` - Provider version constraints
- `examples/basic/` - Basic usage example

## Variables

See [variables.tf](./variables.tf) for complete variable documentation including validation rules.

Key variables:
- `host_count` - Number of dedicated hosts (0-100)
- `availability_zone` - Target AWS availability zone
- `instance_type` - EC2 instance type (mutually exclusive with instance_family)
- `instance_family` - EC2 instance family (mutually exclusive with instance_type)
- `auto_placement` - Enable auto-placement (on/off)
- `host_recovery` - Enable host recovery (on/off)

## Outputs

| Name | Description |
|------|-------------|
| dedicated_host_ids | The IDs of the AWS Dedicated Hosts |
| dedicated_host_arns | The ARNs of the AWS Dedicated Hosts |
| dedicated_host_availability_zones | The availability zones of the Dedicated Hosts |
| dedicated_host_owner_ids | The AWS account IDs of the Dedicated Host owners |
| host_count | The number of dedicated hosts created |
| instance_type | The instance type configured for the dedicated hosts |

## Development

Format code:
```bash
terraform fmt -recursive
```

Validate configuration:
```bash
terraform validate
```

Run linting:
```bash
tflint
```

## Testing

The module includes automated testing with GitHub Actions. See [.github/workflows/terraform-ci.yml](.github/workflows/terraform-ci.yml) for CI configuration.

## Usage Examples

### Basic Example

```hcl
module "dedicated_hosts" {
  source = "github.com/thomasvincent/terraform-aws-host-management"

  host_count        = 2
  availability_zone = "us-east-1a"
  instance_type     = "c5.large"
  environment       = "production"
  project           = "my-app"
  owner             = "platform-team"

  additional_tags = {
    CostCenter = "engineering"
  }
}
```

### Instance Family Example

```hcl
module "dedicated_hosts" {
  source = "github.com/thomasvincent/terraform-aws-host-management"

  host_count        = 1
  availability_zone = "us-west-2b"
  instance_family   = "c5"
  instance_type     = null  # Must be null when using instance_family
  environment       = "staging"
  project           = "data-processing"
}
```

### With Remote State Backend

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "dedicated-hosts/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

module "dedicated_hosts" {
  source = "github.com/thomasvincent/terraform-aws-host-management"

  host_count        = 3
  availability_zone = "us-east-1a"
  instance_type     = "r5.xlarge"
  environment       = "production"
  project           = "database"
}
```

## Requirements

| Name | Version |
|------|---------|
| opentofu | >= 1.6.0 |
| aws | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 5.0.0 |

## License

MIT License - see [LICENSE](LICENSE) for details.

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details.
