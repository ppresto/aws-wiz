output "aws_key_id" {
  description = "Key ID"
  value       = aws_kms_key.cloudtrail.key_id
}

output "aws_key_arn" {
  description = "Key ARN"
  value       = aws_kms_key.cloudtrail.arn
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "bucket_name" {
    value = module.aws_cloud_events.bucket_name
}

output "bucket_arn" {
    value = aws_s3_bucket.cloudtrailBucket.arn
}