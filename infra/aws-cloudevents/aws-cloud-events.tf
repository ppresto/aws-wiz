provider "aws" {}

module "aws_cloud_events" {
  source = "https://s3-us-east-2.amazonaws.com/wizio-public/deployment-v2/aws/wiz-aws-cloud-events-terraform-module.zip"

  integration_type = "S3"

  cloudtrail_bucket_arn = "arn:aws:s3:::aws-cloudtrail-logs-854962865939-9b4bcd54"
  #cloudtrail_kms_arn    = "arn:aws:kms:us-west-2:854962865939:key/d4929040-0c0a-4a9f-b67d-e13370ea1477"

  wiz_access_role_arn = "arn:aws:iam::854962865939:role/WizAccess-Role"
}

output "bucket_name" {
    value = module.aws_cloud_events.bucket_name
}

output "bucket_account" {
    value = module.aws_cloud_events.bucket_account
}