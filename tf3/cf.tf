# cloudfront

resource "aws_cloudfront_origin_access_identity" "access_identity" {
  comment = "Access for cloudfront"
}

resource "aws_cloudfront_distribution" "cf-dist" {
  origin {
    domain_name = "${aws_s3_bucket.website.bucket_domain_name}"
    origin_id   = "origin"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.access_identity.cloudfront_access_identity_path}"
    }
  }

  aliases             = ["${var.domain-name}", "www.${var.domain-name}"]
  enabled             = "true"
  price_class         = "PriceClass_100"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${var.ssl-arn}"
    ssl_support_method  = "sni-only"
  }
}
