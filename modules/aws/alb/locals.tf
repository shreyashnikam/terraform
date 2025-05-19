locals {
  merged_security_groups = {
    for sg_key, sg in var.security_groups : sg_key => {
      name        = sg.name
      description = sg.description
      tags        = sg.tags

      ingress = length(sg.ingress) > 0 ? sg.ingress : tolist([
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = [var.vpc_cidr]
          sg_ids      = []
        }
      ])

      egress = length(sg.egress) > 0 ? sg.egress : tolist([
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

  alb_arn_map = {
    for key, alb in aws_lb.this : key => alb.arn
  }

  target_group_arn_map = {
    for key, tg in aws_lb_target_group.this : key => tg.arn
  }
  
  security_group_ids_map = {
    for key, sg in aws_security_group.this : key => sg.id
  }

  listener_arn_map = {
    for key, listener in aws_lb_listener.this : key => listener.arn
  }
}

