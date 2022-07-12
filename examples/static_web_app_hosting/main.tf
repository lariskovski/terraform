
module "acm_certificate_request" {
  source = "../../modules/acm"

  subdomain = var.subdomain
}

module "cloudflare_certificate_validation" {
  depends_on = [module.acm_certificate_request]

  source = "../../modules/cloudflare"

  zone_domain_name = var.root_domain_name

  for_each = {
    for dvo in module.acm_certificate_request.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  record_name  = each.value.name
  record_value = each.value.record
  record_type  = "CNAME"

}




module "cloudfront_s3_distribution" {
  depends_on = [module.acm_certificate_request]

  source = "../../modules/cloudfront"

  project_name = var.project_name

  alias               = var.subdomain
  acm_certificate_arn = module.acm_certificate_request.acm_certificate_arn

  cloudfront_log_bucket = var.cloudfront_log_bucket

}

module "cloudflare_update_record" {
  depends_on = [module.cloudfront_s3_distribution]

  source = "../../modules/cloudflare"

  zone_domain_name = var.root_domain_name

  record_name     = var.subdomain
  record_value    = module.cloudfront_s3_distribution.distribution_domain_name
  record_type     = "CNAME"
  allow_overwrite = true

}
