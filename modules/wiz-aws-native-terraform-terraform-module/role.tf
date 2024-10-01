resource "aws_iam_role" "user-role-tf" {
  name = var.rolename
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "AWS" : var.remote-arn
          },
          "Action" : "sts:AssumeRole",
          "Condition" : {
            "StringEquals" : {
              "sts:ExternalId" : var.external-id
            }
          }
        }
      ]
    }
  )
  tags = merge(
    var.tags,
    local.wiz_version_last_updated
  )
}
