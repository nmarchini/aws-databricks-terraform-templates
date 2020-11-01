resource "aws_eip" "this" {
  vpc = true

  tags = merge(
    var.default_tags,
    { "Name" = "${local.tag_name_prefix}-Nat-EIP" }
  )
}


resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.natsubnet.id

  tags = merge(
    var.default_tags,
    { "Name" = "${local.tag_name_prefix}-Nat-GQ" }
  )

}
