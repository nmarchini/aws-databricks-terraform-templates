resource random_string "root_s3_suffix" {
  length = 16
  upper  = false

}

resource "aws_s3_bucket" "databricks-e2-dbfs-root" {
  bucket = "databricks-e2-dbfs-root-${random_string.root_s3_suffix.result}"
  acl    = "private"
  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "Grant Databricks Access to Root S3",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::414351767826:root"
      },
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:ListBucket",
        "s3:GetBucketLocation"
      ],
      "Resource": [
        "arn:aws:s3:::databricks-e2-dbfs-root-${random_string.root_s3_suffix.result}/*",
        "arn:aws:s3:::databricks-e2-dbfs-root-${random_string.root_s3_suffix.result}"
      ]
    }
  ]
}
POLICY

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled    = true
    mfa_delete = true
  }



  tags = merge(
    var.default_tags,
    { "Name" = "${local.tag_name_prefix}-e2-dbfs-root" }
  )
}


