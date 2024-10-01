/*
Set the following Env variables to connect to HCP
  variable "HCP_CLIENT_SECRET"
  variable "HCP_CLIENT_ID"
*/

variable "prefix" {
  description = "unique prefix for resources"
  type        = string
  default     = "presto"
}


variable "region" {
  description = "The region of the HCP HVN and Consul cluster."
  type        = string
  default     = "us-west-2"
}

# EC2 Variables
variable "hostname" {
  description = "EC2 Instance name."
  type        = string
  default     = "ubuntu-0747bdcabd34c712a" # Latest Ubuntu 18.04 LTS (HVM), SSD Volume Type
}

variable "ami_id" {
  description = "AMI ID to be used on all AWS EC2 Instances."
  type        = string
  default     = "ami-0747bdcabd34c712a" # Latest Ubuntu 18.04 LTS (HVM), SSD Volume Type
}

variable "use_latest_ami" {
  description = "Whether or not to use the hardcoded ami_id value or to grab the latest value from SSM parameter store."
  type        = bool
  default     = true
}

variable "instance_profile_name" {
  description = "IAM Profile for EC2 instance running a Consul client"
  type        = string
  default     = null
}
variable "ec2_key_pair_name" {
  description = "An existing EC2 key pair used to access the bastion server."
  type        = string
  default     = "ppresto-ptfe-dev-key"
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}
variable "associate_public_ip_address" {
  description = "Public IP"
  type        = bool
  default     = false
}

variable "subnet_id" {
  description = "VPC subnet"
  type        = string
}

variable "security_group_ids" {
  description = "SG IDs"
  type        = list(any)
  default     = []
}

variable "allowed_bastion_cidr_blocks_ipv6" {
  description = "List of CIDR blocks allowed to access your Bastion.  Defaults to none."
  type        = list(string)
  default     = []
}

# Shared bastion host allowed ingress CIDR
variable "allowed_bastion_cidr_blocks" {
  description = "List of CIDR blocks allowed to access your Bastion.  Defaults to Everywhere."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# variable "egress_cidr_blocks" {
#   description = "Allowed egress CIDR blocks. Defaults to Everywhere."
#   type        = list(string)
#   default     = ["0.0.0.0/0"]
# }

locals {
  region_shortname = join("", regex("([a-z]{2}).*-([a-z]).*-(\\d+)", data.aws_region.current.name))
}

variable "bucket_name" {
  description = "VPC subnet"
  type        = string
  default     = "default-bucket-name"
}