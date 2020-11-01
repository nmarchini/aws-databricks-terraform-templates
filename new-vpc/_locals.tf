locals {
  tag_name_prefix = "Databricks-E2-Workspace"                   // Name to be used as the prefix to each tag
  vpc_cidr_block  = "10.173.0.0/16"                             // CIDR Block of the VPC
  subnet1         = "10.173.4.0/22"                             // CIDR Block for subnet 1
  subnet2         = "10.173.8.0/22"                             // CIDR Block for subnet 2
  natsubnet       = "10.173.16.0/28"                            // CIDR Block for natsubnet
  account_id      = data.aws_caller_identity.current.account_id //AWS Account ID for the current account

}
