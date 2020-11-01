resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.subnet1
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = false

  tags = merge(
    var.default_tags,
    { "Name" = "${local.tag_name_prefix}-subnet2" }
  )
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.subnet2
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = false

  tags = merge(
    var.default_tags,
    { "Name" = "${local.tag_name_prefix}-subnet2" }
  )
}

resource "aws_subnet" "natsubnet" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = local.natsubnet
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = false

  tags = merge(
    var.default_tags,
    { "Name" = "${local.tag_name_prefix}-natsubnet" }
  )
}
