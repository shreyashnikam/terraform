locals {
  db_instances = var.db_instances

  db_identifier = {
    for instance_key, instance_config in local.db_instances :
    instance_key => instance_config.db_use_name_prefix ? "${instance_config.db_instance_name}-rds" : instance_config.db_instance_name
  }

  create_db_subnet_group = {
    for instance_key, instance_config in local.db_instances :
    instance_key => instance_config.create_db_subnet_group && length(instance_config.db_subnet_keys) > 0
  }

  db_subnet_ids = {
    for instance_key, instance_config in local.db_instances :
    instance_key => [for subnet_key in instance_config.db_subnet_keys : var.subnet_id_map[subnet_key]]
  }

  create_db_parameter_group = {
    for instance_key, instance_config in local.db_instances :
    instance_key => instance_config.create_db_parameter_group && length(instance_config.db_parameter_group_parameters) > 0
  }

  create_db_option_group = {
    for instance_key, instance_config in local.db_instances :
    instance_key => instance_config.create_db_option_group && length(instance_config.db_option_group_options) > 0
  }

  merged_security_groups = {
    for sg_key, sg_config in var.db_security_groups : sg_key => {
      name        = sg_config.name
      description = sg_config.description
      tags        = sg_config.tags

      ingress = length(sg_config.ingress) > 0 ? sg_config.ingress : tolist([
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = [var.vpc_cidr]
          sg_ids      = []
        }
      ])

      egress = length(sg_config.egress) > 0 ? sg_config.egress : tolist([
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
          sg_ids      = []
        }
      ])
    }
  }

  security_group_ids_map = {
    for sg_key, sg in aws_security_group.this : sg_key => sg.id
  }
}
