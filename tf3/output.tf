output "servers" {
  value = "${data.aws_route53_zone.route53zone.name_servers}"
}