# Static Web App Hosting

This example uses the modules to creates a Cloudfront Distribution with S3 backend with associated ACM certificate. Cloudflare being is used to host the Cloudfront Distribution alias and validate the ACM certificate.

## Requirements

- Cloudflare account with an active zone

- [Cloudflare API TOKEN](https://developers.cloudflare.com/api/tokens/create/)

## Usage
 
After renaming the file `variables.auto.tfvars.example` to `variables.auto.tfvar` and adjusting the variables accordingly, run the folling commands:

~~~~
terraform init -backend-config "bucket=YOUR-TFBUCKET" -backend-config "region=us-east-1"  -backend-config "key=PROJECT-NAME/terraform.tfstate"

terraform plan -out plan

terraform apply plan
~~~~

## Observations

- This is not production-ready code

- Before testing, add at least an `index.html` file into the bucket's root dir otherwise accessing the app will throw `Access Denied` error

- As for pricing these resources are virtually free even outside the initial AWS 12 month period but don't take my word for it: [AWS free tier](https://aws.amazon.com/free/)

- For more cost information: [Infracost Project](https://github.com/infracost/infracost)