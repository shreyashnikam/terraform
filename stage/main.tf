# Creating Network Stack - VPC, Subnets etc..

module "vpc" {
  source          = "../modules/aws/vpc"
  region          = var.region
  env             = var.env  # Change this for stage or prod environments
  vpc_cidr        = var.vpc_cidr
  subnets         = var.subnets
}

# Creating Hosted Zone, Certificates etc..

module "acm" {
  source          = "../modules/aws/acm"
  region_name     = var.region
  domain_name     = var.domain_name
  zone_name       = var.zone_name

  tags = {
    Environment   = var.env
  }
}

# Creating Loadbalancers, Target Groups etc..

module "alb" {
  source             = "../modules/aws/alb"
  region_name        = var.region
  env                = var.env
  vpc_id             = module.vpc.vpc_id
  vpc_cidr           = module.vpc.vpc_cidr
  subnet_id_map      = module.vpc.subnet_ids
  alb_details        = var.alb_details
  security_groups    = var.security_groups
  target_groups      = var.target_groups
  domain_name        = var.domain_name
  certificate_arn    = module.acm.certificate_arn
  listener_rules     = var.listener_rules
  listeners          = var.listeners

  tags = {
    Environment      = var.env
  }
}

# Creating ECS cluster, services, instances, ASG etc..

module "ecs" {
  source                                       = "../modules/aws/ecs"
  region_name                                  = var.region
  account_id                                   = var.account_id
  ecs_clusters                                 = var.ecs_clusters
  env                                          = var.env
  instance_type                                = var.instance_type
  image_id                                     = var.image_id
  ec2_security_groups                          = var.ec2_security_groups
  public_key_path                              = var.public_key_path
  subnet_id_map                                = module.vpc.subnet_ids
  services                                     = var.services
  target_group_arns                            = module.alb.target_group_arns
  vpc_id                                       = module.vpc.vpc_id
  vpc_cidr                                     = module.vpc.vpc_cidr
  asg_max_size                                 = var.asg_max_size
  asg_min_size                                 = var.asg_min_size
  asg_desired_capacity                         = var.asg_desired_capacity
  asg_instance_types                           = var.asg_instance_types
  asg_on_demand_base_capacity                  = var.asg_on_demand_base_capacity
  asg_on_demand_percentage_above_base_capacity = var.asg_on_demand_percentage_above_base_capacity
  asg_spot_allocation_strategy                 = var.asg_spot_allocation_strategy
  tags                                         = var.tags
}

# Creating RDS..

module "rds" {
  source = "../modules/aws/rds"
  db_instances = var.db_instances
  subnet_id_map      = module.vpc.subnet_ids
  db_security_groups = var.db_security_groups
  vpc_cidr           = var.vpc_cidr
  vpc_id             = module.vpc.vpc_id
}

# Elasticache

module "elasticache" {
  source = "../modules/aws/elasticache"

  elasticache_clusters       = var.elasticache_clusters
  elasticache_security_groups = var.elasticache_security_groups
  subnet_id_map              = module.vpc.subnet_ids
  vpc_id                     = module.vpc.vpc_id
  vpc_cidr                   = var.vpc_cidr
}

