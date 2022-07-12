

data "cloudflare_zone" "this" {
  name = var.root_domain_name
}

resource "aws_acm_certificate" "this" {
  domain_name       = var.subdomain
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "this" {
  depends_on = [aws_acm_certificate.this]

  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  zone_id = data.cloudflare_zone.this.id
  name    = each.value.name
  value   = each.value.record
  type    = "CNAME"
  proxied = false
}
