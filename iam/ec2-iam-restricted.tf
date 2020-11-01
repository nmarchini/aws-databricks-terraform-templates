resource "aws_iam_role" "databricks-e2-cross-account-role" {
  name               = "Databricks-E2-Cross-Account-Role"
  path               = "/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::414351767826:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${local.e2_account_id}"
        }
      }
    }
  ]
}
POLICY

  tags = merge(
    var.default_tags,
    { "Name" = "${local.tag_name_prefix}-KMS-key" }
  )

}

resource "aws_iam_role_policy" "databricks-e2-cross-account-role-policy" {
  name   = "Databricks-E2-Cross-Account-Policy"
  role   = aws_iam_role.databricks-e2-cross-account-role.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeIamInstanceProfileAssociations",
        "ec2:DescribeInstanceStatus",
        "ec2:DescribeInstances",
        "ec2:DescribeInternetGateways",
        "ec2:DescribeNatGateways",
        "ec2:DescribeNetworkAcls",
        "ec2:DescribePlacementGroups",
        "ec2:DescribePrefixLists",
        "ec2:DescribeReservedInstancesOfferings",
        "ec2:DescribeRouteTables",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSpotInstanceRequests",
        "ec2:DescribeSpotPriceHistory",
        "ec2:DescribeSubnets",
        "ec2:DescribeVolumes",
        "ec2:DescribeVpcAttribute",
        "ec2:DescribeVpcs",
        "ec2:CreatePlacementGroup",
        "ec2:DeletePlacementGroup",
        "ec2:CreateKeyPair",
        "ec2:DeleteKeyPair",
        "ec2:CreateTags",
        "ec2:DeleteTags",
        "ec2:RequestSpotInstances",
        "ec2:CancelSpotInstanceRequests"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow",
      "Sid": "NonResourceBasedPermissions"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:ResourceTag/Vendor": "Databricks"
        }
      },
      "Action": [
        "ec2:AssociateIamInstanceProfile",
        "ec2:DisassociateIamInstanceProfile",
        "ec2:ReplaceIamInstanceProfileAssociation"
      ],
      "Resource": "arn:aws:ec2:eu-west-1:${local.account_id}:instance/*",
      "Effect": "Allow",
      "Sid": "InstancePoolsSupport"
    },
    {
      "Condition": {
        "StringEquals": {
          "aws:RequestTag/Vendor": "Databricks"
        }
      },
      "Action": "ec2:RunInstances",
      "Resource": [
        "arn:aws:ec2:eu-west-1:${local.account_id}:volume/*",
        "arn:aws:ec2:eu-west-1:${local.account_id}:instance/*"
      ],
      "Effect": "Allow",
      "Sid": "AllowEc2RunInstancePerTag"
    },
    {
      "Condition": {
        "StringEquals": {
          "aws:ResourceTag/Vendor": "Databricks"
        }
      },
      "Action": "ec2:RunInstances",
      "Resource": "arn:aws:ec2:eu-west-1:${local.account_id}:image/*",
      "Effect": "Allow",
      "Sid": "AllowEc2RunInstanceImagePerTag"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:vpc": "arn:aws:ec2:eu-west-1:${local.account_id}:vpc/vpc-66f33a1f"
        }
      },
      "Action": "ec2:RunInstances",
      "Resource": [
        "arn:aws:ec2:eu-west-1:${local.account_id}:network-interface/*",
        "arn:aws:ec2:eu-west-1:${local.account_id}:subnet/*",
        "arn:aws:ec2:eu-west-1:${local.account_id}:security-group/*"
      ],
      "Effect": "Allow",
      "Sid": "AllowEc2RunInstancePerVPCid"
    },
    {
      "Action": "ec2:RunInstances",
      "Effect": "Allow",
      "Sid": "AllowEc2RunInstanceOtherResources",
      "NotResource": [
        "arn:aws:ec2:eu-west-1:${local.account_id}:image/*",
        "arn:aws:ec2:eu-west-1:${local.account_id}:network-interface/*",
        "arn:aws:ec2:eu-west-1:${local.account_id}:subnet/*",
        "arn:aws:ec2:eu-west-1:${local.account_id}:security-group/*",
        "arn:aws:ec2:eu-west-1:${local.account_id}:volume/*",
        "arn:aws:ec2:eu-west-1:${local.account_id}:instance/*"
      ]
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:ResourceTag/Vendor": "Databricks"
        }
      },
      "Action": [
        "ec2:TerminateInstances"
      ],
      "Resource": "arn:aws:ec2:eu-west-1:${local.account_id}:instance/*",
      "Effect": "Allow",
      "Sid": "EC2TerminateInstancesTag"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:ResourceTag/Vendor": "Databricks"
        }
      },
      "Action": [
        "ec2:AttachVolume",
        "ec2:DetachVolume"
      ],
      "Resource": [
        "arn:aws:ec2:eu-west-1:${local.account_id}:instance/*",
        "arn:aws:ec2:eu-west-1:${local.account_id}:volume/*"
      ],
      "Effect": "Allow",
      "Sid": "EC2AttachDetachVolumeTag"
    },
    {
      "Condition": {
        "StringEquals": {
          "aws:RequestTag/Vendor": "Databricks"
        }
      },
      "Action": [
        "ec2:CreateVolume"
      ],
      "Resource": "arn:aws:ec2:eu-west-1:${local.account_id}:volume/*",
      "Effect": "Allow",
      "Sid": "EC2CreateVolumeByTag"
    },
    {
      "Condition": {
        "StringEquals": {
          "ec2:ResourceTag/Vendor": "Databricks"
        }
      },
      "Action": [
        "ec2:DeleteVolume"
      ],
      "Resource": "arn:aws:ec2:eu-west-1:${local.account_id}:volume/*",
      "Effect": "Allow",
      "Sid": "EC2DeleteVolumeByTag"
    },
    {
      "Condition": {
        "StringLike": {
          "iam:AWSServiceName": "spot.amazonaws.com"
        }
      },
      "Action": [
        "iam:CreateServiceLinkedRole",
        "iam:PutRolePolicy"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/spot.amazonaws.com/AWSServiceRoleForEC2Spot",
      "Effect": "Allow"
    }
  ]
}
POLICY
}
