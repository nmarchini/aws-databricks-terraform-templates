variable "default_tags" {
  type        = map(string)
  description = "Map for Default tags to apply to all resources"
  default = {
    createdby   = "Terraform"
    owner_email = "JorisBohnson@numberten.co.uk"
  }
}

