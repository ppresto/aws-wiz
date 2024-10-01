variable "external-id" {
  type = string
}

variable "rolename" {
  type    = string
  default = "WizAccess-Role"
}

variable "remote-arn" {
  type    = string
  default = ""
  description = "Enter the AWS Trust Policy Role ARN for your Wiz data center. You can retrieve it from User Settings, Tenant in the Wiz portal"
}

variable "lightsail-scanning" {
  type    = bool
  default = false
}

variable "data-scanning" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}

locals {
  wiz_version_last_updated = jsondecode(file("${path.module}/timestamp.json"))
}
