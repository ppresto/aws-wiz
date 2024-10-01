module "wiz" {
  source = "s3::https://s3-us-east-2.amazonaws.com/wizio-public/deployment-v2/aws/wiz-aws-native-terraform-terraform-module.zip"
  external-id = "EXTERNAL_ID"
}
output "wiz_connector_arn" {
  value = module.wiz.role_arn
}

