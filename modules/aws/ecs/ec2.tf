resource "aws_key_pair" "ecs_key" {
  key_name   = "${var.env}-ecs-key"
  public_key = file(var.public_key_path)
}

resource "aws_launch_template" "ecs" {
  for_each      = var.ecs_clusters
  name_prefix   = "${each.value.name}-ecs-lt-"
  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ecs_key.key_name

  user_data = base64encode(templatefile("${path.module}/userdata.sh", {
    cluster_name = each.value.name
  }))
  network_interfaces {
    associate_public_ip_address = true
    security_groups    = [for key in each.value.security_group_keys : local.security_group_ids_map[key]]
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  }

  tag_specifications {
    resource_type = "instance"
    tags          = var.tags
  }
}

resource "aws_autoscaling_group" "ecs_asg" {
  for_each              = var.ecs_clusters
  name_prefix           = "${each.value.name}-ecs-asg-"
  max_size              = var.asg_max_size
  min_size              = var.asg_min_size
  desired_capacity      = var.asg_desired_capacity
  vpc_zone_identifier   = [for key in each.value.subnet_keys : var.subnet_id_map[key]]
  protect_from_scale_in = true

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.ecs[each.key].id
        version            = "$Latest"
      }

      override {
        instance_type = var.asg_instance_types[0]
      }

      dynamic "override" {
        for_each = slice(var.asg_instance_types, 1, length(var.asg_instance_types))
        content {
          instance_type = override.value
        }
      }
    }

    instances_distribution {
      on_demand_allocation_strategy             = "prioritized"
      on_demand_base_capacity                   = var.asg_on_demand_base_capacity
      on_demand_percentage_above_base_capacity  = var.asg_on_demand_percentage_above_base_capacity
      spot_allocation_strategy                  = var.asg_spot_allocation_strategy
    }
  }

  lifecycle {
    create_before_destroy = false
  }

  tag {
    key                 = "Name"
    value               = "${each.value.name}-ecs-instance"
    propagate_at_launch = true
  }
}


