output "wiz_access_role_arn" {
  value = aws_iam_role.wiz_access_role-tf.arn
}

output "wiz_scanner_role_arn" {
  value = aws_iam_role.wiz_scanner_role-tf.arn
}

output "wiz_last_updated" {
  value = local.wiz_version_last_updated
}
