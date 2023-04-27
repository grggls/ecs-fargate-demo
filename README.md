# ECS Fargate Demo

Giving Fargate a whirl with Terraform driving the boat.

## Tasks
 - [x] Generate a VPC (VPC01) with public and private subnets, and the required subnets elements (Route tables, Internet gateways, NAT or instance gateways, etc).
 - [x] Provision an ECS cluster and all the required elements: 
   - [ ] security groups
   - [ ] roles
   - [x] log groups
   - [x] Fargate autoscaling / capacity provider
 - [ ] Provision the following components: 
   - [ ] public component
   - [ ] private component
   - [x] database component: please use an AWS managed service.
 - [ ] The components must we interconnected, so for example the public layer must connect to the application layer and the application layer must connect to the database layer. A load balancer with target and auto-scaling groups must be utilized for each layer.
 - [ ] Expose the application to Internet using a load balancer of the type you consider the best for this kind of implementation. No need to assign a domain name or TLS certificates, but explanation of what is required to do it will be necessary.
 - [ ] Select and add five CloudWatch alarms related to the implementation. We will require explanation about the reasons of the selected alarms.
 - [ ] A diagram with the implementation is required.

## Links

Some links to modules, info, demos, container definitions, blogs, or anything else that helps me along the way.

 - https://registry.terraform.io/modules/cloudposse/vpc/aws/latest
 - https://registry.terraform.io/modules/cloudposse/dynamic-subnets/aws/latest
 - https://registry.terraform.io/modules/cloudposse/alb/aws/latest
 - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster
 - https://registry.terraform.io/namespaces/cn-terraform
 - https://github.com/brietsparks/guestbook
 - https://ecsworkshop.com/

## Resources
```
data.aws_iam_policy_document.dynamo_db_data_role_assumption
data.aws_iam_policy_document.dynamodb_data_access
aws_dynamodb_table.guestbook_server
aws_ecs_cluster.cluster
aws_ecs_cluster_capacity_providers.fargate
aws_iam_role.dynamodb_data_access_role
aws_iam_role_policy.dynamodb_data_access
module.alb.aws_lb.default[0]
module.alb.aws_lb_listener.http_forward[0]
module.alb.aws_lb_target_group.default[0]
module.alb.aws_security_group.default[0]
module.alb.aws_security_group_rule.egress[0]
module.alb.aws_security_group_rule.http_ingress[0]
module.cloudwatch_logs.data.aws_caller_identity.current
module.cloudwatch_logs.data.aws_region.current
module.cloudwatch_logs.aws_cloudwatch_log_group.log_group
module.cloudwatch_logs.aws_cloudwatch_log_stream.log_stream
module.cloudwatch_logs.aws_kms_key.encryption_key[0]
module.subnets.data.aws_availability_zones.default[0]
module.subnets.aws_eip.default[0]
module.subnets.aws_eip.default[1]
module.subnets.aws_eip.default[2]
module.subnets.aws_nat_gateway.default[0]
module.subnets.aws_nat_gateway.default[1]
module.subnets.aws_nat_gateway.default[2]
module.subnets.aws_network_acl.private[0]
module.subnets.aws_network_acl.public[0]
module.subnets.aws_network_acl_rule.private4_egress[0]
module.subnets.aws_network_acl_rule.private4_ingress[0]
module.subnets.aws_network_acl_rule.public4_egress[0]
module.subnets.aws_network_acl_rule.public4_ingress[0]
module.subnets.aws_route.nat4[0]
module.subnets.aws_route.nat4[1]
module.subnets.aws_route.nat4[2]
module.subnets.aws_route.public[0]
module.subnets.aws_route_table.private[0]
module.subnets.aws_route_table.private[1]
module.subnets.aws_route_table.private[2]
module.subnets.aws_route_table.public[0]
module.subnets.aws_route_table_association.private[0]
module.subnets.aws_route_table_association.private[1]
module.subnets.aws_route_table_association.private[2]
module.subnets.aws_route_table_association.public[0]
module.subnets.aws_route_table_association.public[1]
module.subnets.aws_route_table_association.public[2]
module.subnets.aws_subnet.private[0]
module.subnets.aws_subnet.private[1]
module.subnets.aws_subnet.private[2]
module.subnets.aws_subnet.public[0]
module.subnets.aws_subnet.public[1]
module.subnets.aws_subnet.public[2]
module.vpc.aws_default_security_group.default[0]
module.vpc.aws_internet_gateway.default[0]
module.vpc.aws_vpc.default[0]
module.alb.module.access_logs.data.aws_partition.current
module.subnets.module.utils.data.aws_regions.default
module.subnets.module.utils.data.aws_regions.not_opted_in
module.subnets.module.utils.data.aws_regions.opted_in
```
