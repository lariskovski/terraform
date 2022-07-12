# AWS Provider variables
variable "region" {
  type = string
}
variable "project_name" {
  type = string
}


variable "root_domain_name" {
  type = string
}

variable "subdomain" {
  type = string
}

variable "cloudfront_log_bucket" {
  type = string
}

# Cloudflare Provider variables
variable "cloudflare_api_token" {
  type = string
}
variable "cloudflare_email" {
  type = string
}
