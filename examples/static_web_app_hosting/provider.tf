# Configure the AWS Provider
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Project = var.project_name
    }
  }
}

provider "cloudflare" {
  email     = var.cloudflare_email
  api_token = var.cloudflare_api_token
}
