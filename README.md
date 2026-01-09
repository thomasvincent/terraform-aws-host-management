# terraform-aws-host-management

Terraform module for provisioning and managing AWS EC2 Dedicated Hosts.

[![Terraform CI](https://github.com/thomasvincent/terraform-aws-host-management/actions/workflows/terraform-ci.yml/badge.svg)](https://github.com/thomasvincent/terraform-aws-host-management/actions/workflows/terraform-ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Features

- Provision multiple AWS EC2 Dedicated Hosts
- Support for instance type or instance family allocation
- Configurable auto-placement and host recovery
- AWS Outpost support
- Comprehensive tagging with validation
- Input validation for all variables

## Usage

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
| terraform | >= 1.5.0 |
| aws | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| host_count | Number of dedicated hosts to create | `number` | `1` | no |
| availability_zone | The availability zone to launch the dedicated host in | `string` | n/a | yes |
| instance_type | The instance type to use for the dedicated host | `string` | `"c5.large"` | no |
| instance_family | Instance family to use (mutually exclusive with instance_type) | `string` | `null` | no |
| auto_placement | Whether to enable auto placement ('on' or 'off') | `string` | `"on"` | no |
| host_recovery | Whether to enable host recovery ('on' or 'off') | `string` | `"on"` | no |
| outpost_arn | The ARN of the AWS Outpost | `string` | `null` | no |
| asset_id | The ID of the Outpost hardware asset | `string` | `null` | no |
| environment | Environment name for tagging | `string` | `"production"` | no |
| project | Project name for tagging | `string` | `""` | no |
| owner | Owner of the resources for tagging | `string` | `""` | no |
| additional_tags | Additional tags to apply | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| dedicated_host_ids | The IDs of the AWS Dedicated Hosts |
| dedicated_host_arns | The ARNs of the AWS Dedicated Hosts |
| dedicated_host_availability_zones | The availability zones of the Dedicated Hosts |
| dedicated_host_owner_ids | The AWS account IDs of the Dedicated Host owners |
| host_count | The number of dedicated hosts created |
| instance_type | The instance type configured for the dedicated hosts |

## License

MIT License - see [LICENSE](LICENSE) for details.

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details.
