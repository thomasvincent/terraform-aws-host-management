# CLAUDE.md

OpenTofu module for managing multiple AWS EC2 Dedicated Hosts with comprehensive tagging and validation.

## Stack
- OpenTofu >= 1.6.0 (migrated from Terraform)
- AWS Provider >= 5.0.0

## Validation Commands

```bash
tofu fmt -check
tofu validate
tofu plan
```

## Module Characteristics
- Provisions multiple dedicated hosts via count parameter
- Enforces tag validation for environment, project, and owner
- Supports AWS Outpost deployment with asset_id tracking
- Mutually exclusive instance_type/instance_family configuration
