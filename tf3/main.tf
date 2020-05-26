# https://westerndevs.com/2018-10-12-cloudfront-terraform/

provider "aws" {
  region = "${var.region}"
  profile = "pvz-dev"
}

terraform {
  backend "s3" {
    bucket = "37sg-tf-state-sheep"
    key    = "environment"
    region = "us-east-1"
  }
}