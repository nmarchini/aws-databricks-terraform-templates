# aws databricks terraform templates
**Databricks Templates for AWS**

I recently needed to stand up a POC for an E2/Enterprise Databricks account, the Databricks components are deployed using the API and not via the Databricks console so there is some configuration to be done in advance in the AWS account. These templates create the necessary AWS resources to allow a Databricks cluster to run in your AWS Account. They are provided as a Terraform alternative to the [CloudFormation templates][2]

More information about Databricks E2 workspace creation using the API can be found [here][3] 

The templates are simple and designed to be run using terraform commands, no Makefile or other helpers are needed, but you are welcome to fork this repository and add your own as needed. 

**Templates**

- IAM - Creates a cross-account IAM role that allows Databricks to provision resources in your VPC (Please read the separate Readme in the IAM folder)
- KMS - Creates KMS key in your account that Databricks will use to encrypt data
- S3 - Creates the root S3 bucket in your account and applies the policy allowing the Databricks account to access it
- New-VPC - Creates a new VPC in your account that the Databricks cluster will be deployed into.
- Existing-VPC - Deploys the necessary resources into an existing VPC to allow a Databricks to run in that VPC


## Requirements

- AWS account
- AWS CLI installed + configured with your API keys
- Git CLI installed

## How to use this code
You will need to already be familiar with AWS CLI and Terraform. If you need to know how to authentication to your AWS account on the CLI then refer to the Terraform docs [Here][1]

- Download the code
- Each folder has a ***_locals.tf*** and ***_variables.tf*** file that you must edit to suit your implementation.
- Authenticate to the AWS account you want to execute the code against
- cd into one of the resources folders (e.g /s3) and then run 
   
  ```cli
  $ terraform init
  ```
- Assuming the command above was successful then run 
  ```cli
  $ terraform plan
  ```
- Check the output is going to create what you expect with the modifications you have made.
- Then run to apply the plan
  ```cli
  $ terraform apply
  ```
  - You can add the -auto-approve switch if you don't want to get prompted to confirm the changes


Repeat these steps for each resource folder you want to deploy


## To do 
Create existing-vpc code

[1]:https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication
[2]:(https://github.com/abhinavg6/awsdb-cf-templates-ext)
[3]:https://docs.databricks.com/administration-guide/account-api/new-workspace.html
