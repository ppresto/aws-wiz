module "aws_cloud_events" {
  source = "https://downloads.wiz.io/customer-files/aws/wiz-aws-cloud-events-terraform-module.zip"

  cloudtrail_arn        = aws_cloudtrail.mgmtEvents.arn
  cloudtrail_bucket_arn = aws_s3_bucket.cloudtrailBucket.arn
  cloudtrail_kms_arn    = aws_kms_key.cloudtrail.arn

  #sns_topic_arn                = "arn:aws:sns:us-west-2:854962865939:wiz-cloudtrail-logs-notify"
  #sns_topic_encryption_enabled = false

  wiz_access_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/WizAccess-Role"
}