output "role_arn" {
  value = aws_iam_role.user-role-tf.arn
}

output "wiz_last_updated" {
  value = local.wiz_version_last_updated
}
