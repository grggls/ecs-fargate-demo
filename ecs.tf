# https://registry.terraform.io/namespaces/cn-terraform
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster

# Encrypted Cloudwatch log group for our ECS Cluster
module "cloudwatch_logs" {
  source                      = "cn-terraform/cloudwatch-logs/aws"
  version                     = "1.0.12"
  logs_path                   = "${local.common_tags.namespace}-${local.common_tags.stage}-ecs-logs"
  create_kms_key              = "true"
  log_group_retention_in_days = 7
  tags                        = local.common_tags
}

resource "aws_ecs_cluster" "cluster" {
  name = "${local.common_tags.namespace}-${local.common_tags.stage}-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      kms_key_id = module.cloudwatch_logs.encryption_key_id
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = module.cloudwatch_logs.log_stream_log_group_name
      }
    }
  }
  tags = local.common_tags
}

resource "aws_ecs_cluster_capacity_providers" "fargate" {
  cluster_name = aws_ecs_cluster.cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}
