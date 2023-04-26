# https://registry.terraform.io/modules/cloudposse/vpc/aws/latest
# we're commenting out some input variables here so that we get a VPC named "VPC01", per the assignment requirements
# these inputs are common to most/all cloudposse modules for naming convention purposes, so we're leaving them in.
module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "2.0.0"
  #namespace               = local.common_tags.namespace
  #stage                   = local.common_tags.stage
  name                    = "VPC01"
  ipv4_primary_cidr_block = local.cidr_block
  tags                    = local.common_tags
}

# https://registry.terraform.io/modules/cloudposse/dynamic-subnets/aws/latest
module "subnets" {
  source             = "cloudposse/dynamic-subnets/aws"
  version            = "2.1.0"
  namespace          = local.common_tags.namespace
  stage              = local.common_tags.stage
  vpc_id             = module.vpc.vpc_id
  ipv4_cidr_block    = [local.cidr_block]
  igw_id             = [module.vpc.igw_id]
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  tags               = local.common_tags
}
