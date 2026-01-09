################################################################################
# AWS Dedicated Host Variables
################################################################################

variable "host_count" {
  type        = number
  default     = 1
  description = "Number of dedicated hosts to create."

  validation {
    condition     = var.host_count >= 0 && var.host_count <= 100
    error_message = "Host count must be between 0 and 100."
  }
}

variable "auto_placement" {
  type        = string
  default     = "on"
  description = "Whether to enable auto placement for the dedicated host. Valid values: 'on' or 'off'."

  validation {
    condition     = contains(["on", "off"], var.auto_placement)
    error_message = "Auto placement must be either 'on' or 'off'."
  }
}

variable "availability_zone" {
  type        = string
  description = "The availability zone to launch the dedicated host in (e.g., 'us-east-1a')."

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9][a-z]$", var.availability_zone))
    error_message = "Availability zone must be a valid AWS AZ format (e.g., 'us-east-1a')."
  }
}

variable "host_recovery" {
  type        = string
  default     = "on"
  description = "Whether to enable host recovery for the dedicated host. Valid values: 'on' or 'off'."

  validation {
    condition     = contains(["on", "off"], var.host_recovery)
    error_message = "Host recovery must be either 'on' or 'off'."
  }
}

variable "instance_type" {
  type        = string
  default     = "c5.large"
  description = "The instance type to use for the dedicated host. Must be compatible with dedicated hosts."

  validation {
    condition     = can(regex("^[a-z][0-9][a-z]?\\.(nano|micro|small|medium|large|xlarge|[0-9]+xlarge|metal)$", var.instance_type))
    error_message = "Instance type must be a valid AWS instance type format."
  }
}

variable "instance_family" {
  type        = string
  default     = null
  description = "Instance family to use for the dedicated host. Mutually exclusive with instance_type."

  validation {
    condition     = var.instance_family == null || can(regex("^[a-z][0-9][a-z]?$", var.instance_family))
    error_message = "Instance family must be a valid format (e.g., 'c5', 'm5', 'r5')."
  }
}

variable "outpost_arn" {
  type        = string
  default     = null
  description = "The ARN of the AWS Outpost on which to allocate the Dedicated Host."

  validation {
    condition     = var.outpost_arn == null || can(regex("^arn:aws:outposts:", var.outpost_arn))
    error_message = "Outpost ARN must be a valid AWS Outpost ARN."
  }
}

variable "asset_id" {
  type        = string
  default     = null
  description = "The ID of the Outpost hardware asset on which to allocate the Dedicated Hosts."
}

################################################################################
# Tagging Variables
################################################################################

variable "environment" {
  type        = string
  default     = "production"
  description = "Environment name for tagging (e.g., 'production', 'staging', 'development')."

  validation {
    condition     = contains(["production", "staging", "development", "test", "qa"], var.environment)
    error_message = "Environment must be one of: production, staging, development, test, qa."
  }
}

variable "project" {
  type        = string
  default     = ""
  description = "Project name for tagging and resource identification."
}

variable "owner" {
  type        = string
  default     = ""
  description = "Owner of the resources for tagging."
}

variable "additional_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to the dedicated host."
}
