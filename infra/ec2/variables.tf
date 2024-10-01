locals {
  name = "${var.prefix}-${replace(basename(path.cwd), "_", "-")}"
  #region_shortname = join("", regex("([a-z]{2}).*-([a-z]).*-(\\d+)", data.aws_region.current.name))
  tags = {
    Project    = local.name
    GithubRepo = "aws-consul-pagerduty"
    GithubOrg  = "ppresto"
  }

}

variable "prefix" {
  description = "Unique name to identify all resources. Try using your name."
  type        = string
  default     = "presto"
}

variable "ec2_key_pair_name" {
  description = "An existing EC2 key pair used to access the bastion server."
  type        = string
  default     = "my-insecure-keypair-20240930"
}

variable "route53_zone" {
  description = "My Hosted Zone"
  type        = string
  default     = "my.route53.hosted.zone."
}
variable "allowed_bastion_cidr_blocks" {
  description = "List of CIDR blocks allowed to access your Bastion.  Defaults to Everywhere."
  type        = list(string)
  default     = ["52.119.127.230/32"]
}
variable "egress_cidr_blocks" {
  description = "List of CIDR blocks allowed to access your Bastion.  Defaults to Everywhere."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}