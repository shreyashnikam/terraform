output "alb_arn_map" {
  value = {
    for alb_key, alb in aws_lb.this : alb_key => alb.arn
  }
}

output "target_group_arns" {
  value = {
    for target_group_arn, tg in aws_lb_target_group.this : target_group_arn => tg.arn
  }
}

output "security_group_ids" {
  description = "Map of security group IDs"
  value = {
    for key, sg in aws_security_group.this : key => sg.id
  }
}

