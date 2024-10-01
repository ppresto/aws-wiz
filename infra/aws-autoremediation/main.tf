module "wiz-remediation" {
  region     = "us-west-2"
  source     = "https://wizio-public.s3.amazonaws.com/deployment-v2/aws/wiz-aws-remediation-stack-terraform-module.zip"
  ExternalId = var.external_id
  RoleARN    = "arn:aws:iam::197171649850:role/prod-us20-AssumeRoleDelegator"
  WizRemediationTagValue = {
    wiz-remediation = "7c19c140-882f-435a-b947-c65df722b60b"
  }
  WizRemediationCustomFunctionsBucketEnabled = true
  WizRemediationCustomFunctionsBucketName = "presto-aws-autoremediation-usw2"
  # WizRemediationEnabledAutoTagOnUpdate - defaults to true
  # WizRemediationAutoTagKey - defaults to "wizAutoRemediationLastUpdated"
  # WizRemediationAutoTagDateFormat - defaults to "DDMMYY"
  # WizRemediationResourcesPrefix - defaults to "Wiz"
  # region defaults to "us-east-2"
  # aws_profile defaults to "", taking the profile from the environment
}

output "wiz_remediation_outputs" {
  value = module.wiz-remediation
}