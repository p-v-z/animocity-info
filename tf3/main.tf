# https://westerndevs.com/2018-10-12-cloudfront-terraform/

provider "aws" {
  region = "${var.region}"
  profile = "${var.profile}"
}

// Remember to run terraform init -reconfigure
terraform {
  backend "s3" {
    bucket = "a82z-tf-state-animocity"
    key    = "environment"
    region = "us-east-1"
  }
}