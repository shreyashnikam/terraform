locals {
  elasticache_subnet_ids = {
    for cluster_key, cluster in var.elasticache_clusters :
    cluster_key => [for subnet_key in cluster.subnet_keys : var.subnet_id_map[subnet_key]]
  }

  security_group_ids = {
    for sg_key, sg in aws_security_group.elasticache : sg_key => sg.id
  }

  cluster_security_groups = {
    for cluster_key, cluster in var.elasticache_clusters :
    cluster_key => [for key in cluster.security_group_keys : local.security_group_ids[key]]
  }

  merged_security_groups = {
    for sg_key, sg_config in var.elasticache_security_groups : sg_key => {
      name        = sg_config.name
      description = sg_config.description
      tags        = sg_config.tags

      ingress = length(sg_config.ingress) > 0 ? sg_config.ingress : [{
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [var.vpc_cidr]
        sg_ids      = []
      }]

      egress = length(sg_config.egress) > 0 ? sg_config.egress : [{
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        sg_ids      = []
      }]
    }
  }
}
