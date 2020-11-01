resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.default_tags,
    { "Name" = "${local.tag_name_prefix}-IGW" }
  )
}

