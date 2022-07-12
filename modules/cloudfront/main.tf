# =============================
#  S3 BUCKET
# =============================

resource "aws_s3_bucket" "this" {
  bucket = var.project_name
}

resource "aws_s3_bucket_acl" "this" {
  bucket = var.project_name
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = var.project_name

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = var.project_name
  policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {
  statement {
    sid    = "S3AllowCloudfrontOAI"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.this.iam_arn]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = ["${aws_s3_bucket.this.arn}/*"]

  }
}

# =============================
#  CLOUDFRONT
# =============================

locals {
  s3_origin_id = "default"
}

resource "aws_cloudfront_origin_access_identity" "this" {}

resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = aws_s3_bucket.this.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["HEAD", "GET"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  aliases = [var.alias]

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  logging_config {
    bucket          = "${var.cloudfront_log_bucket}.s3.amazonaws.com"
  }

}

# =============================
#  CLOUDFLARE
# =============================

data "cloudflare_zone" "this" {
  name = var.root_domain_name
}

resource "cloudflare_record" "this" {
  depends_on = [aws_cloudfront_distribution.this]

  zone_id         = data.cloudflare_zone.this.id
  name            = var.alias
  value           = aws_cloudfront_distribution.this.domain_name
  type            = "CNAME"
  proxied         = false
  allow_overwrite = true
}
