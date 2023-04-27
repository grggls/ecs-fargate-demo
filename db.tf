# https://github.com/brietsparks/guestbook

# create a persistent data store for our guestbook in dynamo
resource "aws_dynamodb_table" "guestbook_server" {
  name           = "${local.common_tags.namespace}_${local.common_tags.stage}_dynamo_guestbook"
  read_capacity  = 15
  write_capacity = 15
  hash_key       = "ip"
  range_key      = "ts"

  attribute {
    name = "ip"
    type = "S"
  }

  attribute {
    name = "ts"
    type = "N"
  }

  tags = local.common_tags
}

# Allow an ECS task to read and write to DynamoDB
resource "aws_iam_role" "dynamodb_data_access_role" {
  name               = "${local.common_tags.namespace}_${local.common_tags.stage}_dynamo_data_access_role"
  description        = "Provides write and read access to DynamoDB data"
  assume_role_policy = data.aws_iam_policy_document.dynamo_db_data_role_assumption.json
  tags               = local.common_tags
}

data "aws_iam_policy_document" "dynamo_db_data_role_assumption" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role_policy" "dynamodb_data_access" {
  name   = "${local.common_tags.namespace}_${local.common_tags.stage}_dynamo_data_access"
  role   = aws_iam_role.dynamodb_data_access_role.id
  policy = data.aws_iam_policy_document.dynamodb_data_access.json
}

data "aws_iam_policy_document" "dynamodb_data_access" {
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:CreateTable",
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:ListGlobalTables",
      "dynamodb:PutItem",
      "dynamodb:DescribeTable",
      "dynamodb:ListTables",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:UpdateItem",
      "dynamodb:UpdateTable"
    ]
    resources = [
      aws_dynamodb_table.guestbook_server.arn
    ]
  }
}

