resource "aws_route_table_association" "subnet1" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.subnet1.id
}

resource "aws_route_table_association" "subnet2" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.subnet2.id
}

resource "aws_route_table_association" "natsubnet" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.natsubnet.id
}
