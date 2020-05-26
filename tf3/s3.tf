# s3 for sites
resource "aws_s3_bucket" "website" {
  bucket = "${var.domain-name}"
  acl    = "public-read"

  policy = <<EOF
{
    "Version":"2008-10-17",
    "Statement":[{
    "Sid":"AllowPublicRead",
    "Effect":"Allow",
    "Principal": {"AWS": "*"},
    "Action":["s3:GetObject"],
    "Resource":["arn:aws:s3:::${var.domain-name}/*"]
    }]
}
EOF

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  # logging {
  #     target_bucket = "${aws_s3_bucket.site_log_bucket.id}"
  #   }

  #   versioning {
  #     enabled = true
  #   }
}
