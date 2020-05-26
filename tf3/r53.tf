# route 53
data "aws_route53_zone" "route53zone" {
  name = "${var.domain-name}."
}

# bare domain
resource "aws_route53_record" "domain" {
  zone_id = "${data.aws_route53_zone.route53zone.zone_id}"
  name    = "${var.domain-name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.cf-dist.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.cf-dist.hosted_zone_id}"
    evaluate_target_health = false
  }
}

#www domain
resource "aws_route53_record" "www-domain" {
  zone_id = "${data.aws_route53_zone.route53zone.zone_id}"
  name    = "www.${var.domain-name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.cf-dist.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.cf-dist.hosted_zone_id}"
    evaluate_target_health = false
  }
}