# ECS Fargate Demo

Giving Fargate a whirl with Terraform driving the boat.

## Tasks
 - [x] Generate a VPC (VPC01) with public and private subnets, and the required subnets elements (Route tables, Internet gateways, NAT or instance gateways, etc).
 - [ ] Provision an application using ECS with EC2 and Fargate with the following elements: public component, private component, database component and all the required elements (security groups, roles, log groups, etc). The components must we interconnected, so for example the public layer must connect to the application layer and the application layer must connect to the database layer. A load balancer with target and auto-scalation groups must be utilized for each layer.
 - [ ] For the database layer, please use an AWS managed service.
 - [ ] Expose the application to Internet using a load balancer of the type you consider the best for this kind of implementation. No need to assign a domain name or TLS certificates, but explanation of what is required to do it will be necessary.
 - [ ] Select and add five CloudWatch alarms related to the implementation. We will require explanation about the reasons of the selected alarms.
 - [ ] A diagram with the implementation is required.

## Resources

Some links to modules, info, demos, container definitions, blogs, or anything else that helps me along the way.

 - https://registry.terraform.io/modules/cloudposse/vpc/aws/latest
 - https://registry.terraform.io/modules/cloudposse/dynamic-subnets/aws/latest
 - https://registry.terraform.io/modules/cloudposse/alb/aws/latest
