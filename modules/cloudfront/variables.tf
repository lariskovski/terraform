variable "project_name" {
  type    = string
  default = "tv-series-react-front"
}

variable "acm_certificate_arn" {
  type = string
}

variable "root_domain_name" {
  type = string
}

variable "alias" {
  type = string
}

variable "cloudflare_api_token" {
  type = string
}

variable "cloudflare_email" {
  type = string
}

variable "cloudfront_log_bucket" {
  type = string
}

