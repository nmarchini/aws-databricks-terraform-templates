resource "aws_security_group" "Databricks-E2-Workspace-SG" {
  name        = "Databricks-E2-Workspace-SG"
  description = "Allow access from within the same security group"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = []
    self            = true
  }

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "udp"
    security_groups = []
    self            = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.default_tags,
    { "Name" = "${local.tag_name_prefix}-WorkspaceSecurityGroup" }
  )
}
