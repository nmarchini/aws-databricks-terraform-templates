resource "aws_kms_key" "this" {
  description         = "KMS Key used by Databricks to encrypt/decrypt the notebooks for a workspace"
  key_usage           = "ENCRYPT_DECRYPT"
  is_enabled          = true
  enable_key_rotation = false

  policy = <<POLICY
{
  "Version" : "2008-10-17",
  "Statement" : [ {
    "Sid" : "Enable Owner Account Permissions",
    "Effect" : "Allow",
    "Principal" : {
      "AWS" : "arn:aws:iam::${local.account_id}:root"
    },
    "Action" : "kms:*",
    "Resource" : "*"
  }, {
    "Sid" : "Allow Databricks to use KMS key for BYOK",
    "Effect" : "Allow",
    "Principal" : {
      "AWS" : "arn:aws:iam::414351767826:root"
    },
    "Action" : [ "kms:Encrypt", "kms:Decrypt" ],
    "Resource" : "*"
  } ]
}
POLICY

  tags = merge(
    var.default_tags,
    { "Name" = "${local.tag_name_prefix}-KMS-key" }
  )
}

resource "aws_kms_alias" "databricks-e2-byok-key" {
  name          = "alias/databricks-e2-byok-key"
  target_key_id = aws_kms_key.this.id
}
