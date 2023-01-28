variable "auto_placement" {
  default = "on"
}

variable "availability_zone" {
  default = "us-east-1a"
}

variable "host_recovery" {
  default = "on"
}

variable "instance_type" {
  default = "c4.large"
}

variable "tags" {
  default = {}
}

resource "aws_dedicated_host" "example" {
  auto_placement  = var.auto_placement
  availability_zone = var.availability_zone
  host_recovery = var.host_recovery
  instance_type = var.instance_type
  tags = var.tags
}

output "host_id" {
  value = aws_dedicated_host.example.id
}
