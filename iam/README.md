# IAM TF Templates
**Databricks IAM Templates for AWS**

These templates create the necessary AWS IAM resources to allow a Databricks cluster to run in your AWS Account. They are provided as a Terraform alternative to the [CloudFormation templates][3]

The templates are simple and designed to be run using terraform commands, no Makefile or other helpers are needed, but you are welcome to fork this repository and add your own as needed. 

**Templates**
Check the documentation here for which role you need for each of the three different deployment scenarios [link][2]

- ec2-iam-starter - template for a Databricks Cross-Account IAM Role with Starter Policy Deployment
- ec2-iam-restricted - template for a Databricks Cross-Account IAM Role with Restricted Policy Deployment
- ec2-iam-restricted-with-sg - template for a Databricks Cross-Account IAM Role with Restricted Policy Deployment and security group




## How to use this code
You will need to already be familiar with AWS CLI and Terraform. If you need to know how to authentication to your AWS account on the CLI then refer to the Terraform docs [Here][1]

- Download the code
- Each folder has a ***_locals.tf*** and ***_variables.tf*** file that you must edit to suit your implementation.
- This folders has 3 IAM role templates, you will only need one of these, either rename the two you don't need (add .txt so terraform will ignore them) or delete the files you don't need.
- Authenticate to the AWS account you want to execute the code against
- From the /iam folder run 
   
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


Useful Reading = https://docs.databricks.com/administration-guide/account-api/iam-role.html 

[1]:https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication
[2]:https://docs.databricks.com/administration-guide/account-api/iam-role.html#0-language-Databricks%C2%A0VPC
[3]:https://github.com/abhinavg6/awsdb-cf-templates-ext