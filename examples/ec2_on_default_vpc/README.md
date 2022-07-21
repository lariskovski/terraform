# EC2 on Default VPC

## Usage
 
After renaming the file `variables.auto.tfvars.example` to `variables.auto.tfvar` and adjusting the variables accordingly, run the folling commands:

~~~~
terraform init -backend-config "bucket=YOUR-TFBUCKET" -backend-config "region=us-east-1"  -backend-config "key=PROJECT-NAME/terraform.tfstate"
terraform fmt --recursive
terraform validate .
terraform plan -out plan
terraform apply plan
~~~~

## Observations

- This is not production-ready code

- For more cost information: [Infracost Project](https://github.com/infracost/infracost)