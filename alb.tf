# https://registry.terraform.io/modules/cloudposse/alb/aws/latest
module "alb" {
  source                            = "cloudposse/alb/aws"
  version                           = "1.7.0"
  namespace                         = local.common_tags.namespace
  stage                             = local.common_tags.stage
  name                              = "alb"
  vpc_id                            = module.vpc.vpc_id
  security_group_ids                = [module.vpc.vpc_default_security_group_id]
  subnet_ids                        = module.subnets.public_subnet_ids
  internal                          = false
  http_enabled                      = true
  access_logs_enabled               = false
  cross_zone_load_balancing_enabled = true
  http2_enabled                     = true
  deletion_protection_enabled       = false
  tags                              = local.common_tags
}
