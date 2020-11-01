resource "aws_vpc" "this" {
  cidr_block           = local.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = merge(
    var.default_tags,
    { "Name" = "${local.tag_name_prefix}-VPC" }
  )
}
