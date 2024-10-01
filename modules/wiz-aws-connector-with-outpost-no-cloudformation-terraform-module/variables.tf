variable "external-id" {
  type = string
}

variable "wiz_access_rolename" {
  type    = string
  default = "WizAccess-Role"
}

variable "wiz_scanner_rolename" {
  type    = string
  default = "WizScannerRole"
}

variable "remote-arn" {
  type    = string
  default = ""
}

variable "outpost-remote-arn" {
  type    = string
  default = "arn:aws:iam::<OUTPOSTACCOUNTID>:role/WizOrchestratorNodePoolRole"
}

variable "lightsail-scanning" {
  type        = bool
  default     = false
  description = "Enable Lightsail scanning"
}

variable "data-scanning" {
  type    = bool
  default = false
  description = "Enable data scanning"
}

variable "serverless_scanning" {
  type = bool
  default = false
  description = "Enable serverless scanning"
}

variable "tags" {
  type    = map(string)
  default = {}
}

locals {
  wiz_version_last_updated = jsondecode(file("${path.module}/timestamp.json"))
}
