data "cloudflare_zone" "this" {
  name = var.zone_domain_name
}

resource "cloudflare_record" "this" {
  zone_id         = data.cloudflare_zone.this.id
  name            = var.record_name
  value           = var.record_value
  type            = var.record_type
  proxied         = var.proxied
  allow_overwrite = var.allow_overwrite
}