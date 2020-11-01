locals {
  tag_name_prefix = "Databricks-E2-Workspace"                   // Name to be used as the prefix to each tag
  account_id      = data.aws_caller_identity.current.account_id //AWS Account ID for the current account

}
