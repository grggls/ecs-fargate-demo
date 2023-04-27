# https://registry.terraform.io/modules/cn-terraform/ecs-fargate-task-definition
# brietsparks/guestbook-client
# brietsparks/guestbook-server

# Role for ECS tasks to assume 
resource "aws_iam_role" "guestbook_task_execution" {
  name               = "${local.common_tags.namespace}-${local.common_tags.stage}-guestbook_task_execution"
  assume_role_policy = data.aws_iam_policy_document.guestbook_task_execution.json
  tags               = local.common_tags
}

# Ensure ecs tasks can assume the role
data "aws_iam_policy_document" "guestbook_task_execution" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# permissions for the role. see: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html
resource "aws_iam_role_policy_attachment" "guestbook_task_execution" {
  role       = aws_iam_role.guestbook_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

module "guestbook_server_task_definition" {
  source                       = "cn-terraform/ecs-fargate-task-definition/aws"
  version                      = "1.0.32"
  container_image              = "brietsparks/guestbook-server"
  container_name               = "guestbook-server"
  name_prefix                  = "${local.common_tags.namespace}-${local.common_tags.stage}-server"
  container_cpu                = "256"
  container_memory             = "512"
  container_memory_reservation = "512"
  task_role_arn                = aws_iam_role.guestbook_task_execution.arn
  tags                         = local.common_tags
}

module "guestbook_client_task_definition" {
  source                       = "cn-terraform/ecs-fargate-task-definition/aws"
  version                      = "1.0.32"
  container_image              = "brietsparks/guestbook-client"
  container_name               = "guestbook-client"
  name_prefix                  = "${local.common_tags.namespace}-${local.common_tags.stage}-client"
  container_cpu                = "256"
  container_memory             = "512"
  container_memory_reservation = "512"
  task_role_arn                = aws_iam_role.guestbook_task_execution.arn
  tags                         = local.common_tags
}
