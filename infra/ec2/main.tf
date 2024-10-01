data "aws_region" "usw2" {}
data "aws_availability_zones" "usw2" {
  state = "available"
}
data "aws_caller_identity" "usw2" {}

data "aws_iam_policy" "ebscsi-usw2" {
  name = "AmazonEBSCSIDriverPolicy"
}

# Create usw2 VPCs defined in local.usw2
module "myvpc" {
  # https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
  providers = {
    aws = aws.usw2
  }
  source                   = "terraform-aws-modules/vpc/aws"
  version                  = "~> 5.7.0"
  name                     = "${var.prefix}-vpc"
  cidr                     = "10.15.0.0/20"
  azs                      = [data.aws_availability_zones.usw2.names[0], data.aws_availability_zones.usw2.names[1]]
  private_subnets          = ["10.15.1.0/24", "10.15.2.0/24", "10.15.3.0/24"]
  public_subnets           = ["10.15.11.0/24", "10.15.12.0/24", "10.15.13.0/24"]
  enable_nat_gateway       = true
  single_nat_gateway       = true
  enable_dns_hostnames     = true
  enable_ipv6              = false
  default_route_table_name = "${var.prefix}-vpc"

  # Cloudwatch log group and IAM role will be created
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true

  flow_log_max_aggregation_interval         = 60
  flow_log_cloudwatch_log_group_name_prefix = "/aws/${var.prefix}-vpc"
  flow_log_cloudwatch_log_group_name_suffix = "flow"

  tags = {
    Terraform = "true"
    Owner     = "${var.prefix}"
  }
  private_subnet_tags = {
    Tier = "Private"
    # "kubernetes.io/role/internal-elb"                 = 1
    # "kubernetes.io/cluster/${var.prefix}-shared-usw2" = "shared"
  }
  public_subnet_tags = {
    Tier                                                                                     = "Public"
    "kubernetes.io/role/elb"                                                                 = 1
    "kubernetes.io/cluster/${var.prefix}-shared-usw2}" = "shared"
  }
  default_route_table_tags = {
    Name = "${var.prefix}-vpc-default"
  }
  private_route_table_tags = {
    Name = "${var.prefix}-vpc-private"
  }
  public_route_table_tags = {
    Name = "${var.prefix}-vpc-public"
  }
}

module "ec2" {
  providers = {
    aws = aws.usw2
  }
  source   = "../../modules/aws_ec2"

  hostname                    ="${var.prefix}-1"
  ec2_key_pair_name           = var.ec2_key_pair_name
  vpc_id                      = module.myvpc.vpc_id
  prefix                      = var.prefix
  associate_public_ip_address = true
  subnet_id                   = module.myvpc.public_subnets[0]
  security_group_ids          = [module.ec2-sg.securitygroup_id]
  instance_profile_name       = module.ec2_profile.instance_profile_name
  allowed_bastion_cidr_blocks = var.allowed_bastion_cidr_blocks
  bucket_name                 = module.s3.bucket_name
}

module "ec2_profile" {
  providers = {
    aws = aws.usw2
  }
  source        = "../../modules/aws_ec2_iam_profile"
  role_name     = "${var.prefix}-1-role"
  s3_bucket_arn = module.s3.bucket_arn
}
module "ec2-sg" {
  providers = {
    aws = aws.usw2
  }
  source                = "../../modules/aws_ec2_sg_mongod"
  security_group_create = true
  name_prefix           = "${var.prefix}-ec2-sg"
  vpc_id                = module.myvpc.vpc_id
  vpc_cidr_blocks       = ["10.15.0.0/20"]
  private_cidr_blocks   = ["10.15.0.0/20"]
}
module "s3" {
  providers = {
    aws = aws.usw2
  }
  source                    = "../../modules/aws_s3_bucket_public"
  bucket_name               = "${var.prefix}-1-s3-backup"
  bucket_ownership_controls = "BucketOwnerPreferred"
}