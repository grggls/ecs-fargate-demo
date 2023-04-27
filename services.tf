# https://registry.terraform.io/modules/cn-terraform/ecs-fargate-service/aws/latest
module "guestbook_server_fargate_service" {
  source                            = "cn-terraform/ecs-fargate-service/aws"
  version                           = "2.0.39"
  task_definition_arn               = module.guestbook_server_task_definition.aws_ecs_task_definition_td_arn
  container_name                    = module.guestbook_server_task_definition.container_name
  desired_count                     = "2"
  ecs_cluster_arn                   = aws_ecs_cluster.cluster.arn
  ecs_cluster_name                  = aws_ecs_cluster.cluster.name
  name_prefix                       = "guestbook-server"
  public_subnets                    = module.subnets.public_subnet_ids
  private_subnets                   = module.subnets.private_subnet_ids
  vpc_id                            = module.vpc.vpc_id
  lb_security_groups                = [module.vpc.vpc_default_security_group_id]
  enable_s3_logs                    = false
  lb_internal                       = true
  lb_target_group_health_check_path = "/health"
  lb_https_ports                    = {}
  propagate_tags                    = "TASK_DEFINITION"
  tags                              = local.common_tags
}

module "guestbook_client_fargate_service" {
  source                            = "cn-terraform/ecs-fargate-service/aws"
  version                           = "2.0.39"
  task_definition_arn               = module.guestbook_client_task_definition.aws_ecs_task_definition_td_arn
  container_name                    = module.guestbook_client_task_definition.container_name
  desired_count                     = "2"
  ecs_cluster_arn                   = aws_ecs_cluster.cluster.arn
  ecs_cluster_name                  = aws_ecs_cluster.cluster.name
  name_prefix                       = "guestbook-client"
  public_subnets                    = module.subnets.public_subnet_ids
  private_subnets                   = module.subnets.private_subnet_ids
  vpc_id                            = module.vpc.vpc_id
  lb_security_groups                = [module.vpc.vpc_default_security_group_id]
  enable_s3_logs                    = false
  lb_target_group_health_check_path = "/health"
  lb_https_ports                    = {}
  propagate_tags                    = "TASK_DEFINITION"
  tags                              = local.common_tags
}

# output the DNS name of the client ALB so we can curl it
output "guestbook_client_alb_dns_name" {
  value = module.guestbook_client_fargate_service.aws_lb_lb_dns_name
}
