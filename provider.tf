provider "aws" {
  region = "us-west-2"
}

locals {
  common_tags = {
    terraform = "true"
    namespace = "fargate-demo"
    stage     = "dev"
  }
  cidr_block = "10.0.0.0/16"
}

