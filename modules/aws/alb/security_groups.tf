resource "aws_security_group" "this" {
  for_each = local.merged_security_groups

  name        = each.value.name
  description = each.value.description
  vpc_id      = var.vpc_id
  tags        = each.value.tags
}

resource "aws_security_group_rule" "ingress" {
  for_each = {
    for idx, rule in flatten([
      for sg_key, sg in local.merged_security_groups : [
        for rule in sg.ingress : {
          sg_key            = sg_key
          security_group_id = local.security_group_ids_map[sg_key]
          from_port         = rule.from_port
          to_port           = rule.to_port
          protocol          = rule.protocol
          cidr_blocks       = rule.cidr_blocks
        }
      ]
    ]) : "${rule.sg_key}-${idx}" => rule
  }

  type              = "ingress"
  security_group_id = each.value.security_group_id
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
}

resource "aws_security_group_rule" "egress" {
  for_each = {
    for idx, rule in flatten([
      for sg_key, sg in local.merged_security_groups : [
        for rule in sg.egress : {
          sg_key            = sg_key
          security_group_id = local.security_group_ids_map[sg_key]
          from_port         = rule.from_port
          to_port           = rule.to_port
          protocol          = rule.protocol
          cidr_blocks       = rule.cidr_blocks
        }
      ]
    ]) : "${rule.sg_key}-${idx}" => rule
  }

  type              = "egress"
  security_group_id = each.value.security_group_id
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
}





