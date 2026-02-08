# Terraform AWS Host Management

## Purpose
OpenTofu module for provisioning and managing multiple AWS EC2 Dedicated Hosts.

## Stack
- OpenTofu >= 1.6.0 (HCL)
- AWS provider

## Structure
- `main.tf`, `variables.tf`, `outputs.tf`, `versions.tf` - module root
- `examples/` - usage examples

## Build & Test
```bash
tofu init
tofu validate
tofu plan
tofu test          # native testing framework
```

## Standards
- OpenTofu preferred over Terraform
- Tag all resources consistently
- Input validation blocks on all variables
- Google Terraform Style Guide
- Conventional Commits: `type(scope): description`

## Conventions
- Supports instance type or instance family allocation
- Host recovery and auto-placement configurable
- AWS Outpost support
- S3 backend with DynamoDB locking for remote state
