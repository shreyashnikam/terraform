# Network details..

region = "ap-south-1"
account_id = "541729811589"
env    = "stage"
vpc_cidr = "10.7.0.0/16"
domain_name = "*.stage.pratilipi.com"
zone_name   = "stage.pratilipi.com"

subnets = {
  "stage-public-subnet-1" = {
    az_suffix    = "a"
    subnet_index = 0
    type         = "public"
  }
  "stage-public-subnet-2" = {
    az_suffix    = "b"
    subnet_index = 1
    type         = "public"
  }
  "stage-public-subnet-3" = {
    az_suffix    = "c"
    subnet_index = 2
    type         = "public"
  }
  "stage-private-subnet-1" = {
    az_suffix    = "a"
    subnet_index = 4
    type         = "private"
  }
  "stage-private-subnet-2" = {
    az_suffix    = "b"
    subnet_index = 5
    type         = "private"
  }
  "stage-private-subnet-3" = {
    az_suffix    = "c"
    subnet_index = 6
    type         = "private"
  }
}

# Loadbalancer details..

alb_details = {
  public-alb = {
    name                = "stage-public-alb"
    internal            = false
    load_balancer_type  = "application"
    subnet_keys         = ["stage-public-subnet-1","stage-public-subnet-2"]
    security_group_keys = ["alb_public"]
    tags = {
      Environment = "stage"
    }
  }
  private-alb = {
    name                = "stage-private-alb"
    internal            = true
    load_balancer_type  = "application"
    subnet_keys         = ["stage-private-subnet-1","stage-private-subnet-2"]
    security_group_keys = ["alb_private"]
    tags = {
      Environment = "stage"
    }
  }
}

listeners = {
  public_https = {
    alb_key          = "public-alb"
    port             = 443
    protocol         = "HTTPS"
    target_group_key = "ecs-stage-literature-web"
  }

  private_http = {
    alb_key          = "private-alb"
    port             = 8080
    protocol         = "HTTP"
    target_group_key = "ecs-stage-global-catch-all"
  }

  http_8086 = {
    alb_key          = "private-alb"
    port             = 8086
    protocol         = "HTTP"
    target_group_key = "ecs-stage-graphql-gateway"
  }
  http_8888 = {
    alb_key          = "private-alb"
    port             = 8888
    protocol         = "HTTP"
    target_group_key = "ecs-stage-global-catch-all"
  }
  http_8081 = {
    alb_key          = "private-alb"
    port             = 8081
    protocol         = "HTTP"
    target_group_key = "ecs-stage-seo-suite"
  }
}


target_groups = {
  "ecs-audio-stage-audio-history" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-audio-stage-audio-history"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "audio-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-global-catch-all" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-global-catch-all"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "global-catch-all-target-group"
    }
    target_type = "instance"
  }
  "ecs-audio-stage-audio-io" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-audio-stage-audio-io"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "audio-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-audio-stage-audio-jack" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-audio-stage-audio-jack"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "audio-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-audio-stage-audio-notif" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-audio-stage-audio-notif"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "audio-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-audio-stage-audio-social-new" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-audio-stage-audio-social-new"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "audio-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-audio-stage-audio-subscribe" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-audio-stage-audio-subscribe"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "audio-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-audio-stage-audio-tape" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-audio-stage-audio-tape"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "audio-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-audio-stage-audio-web" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-audio-stage-audio-web"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "audio-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-ads" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-ads"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "Literature"
      Environment = "stage"
      Type = "ec2"
      Usecase = "ads"
      Name = "Tg-ecs-stage-ads"
    }
    target_type = "instance"
  }
  "ecs-stage-aggregator" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-aggregator"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "literature"
      Environment = "stage"
      Type = "ec2"
      Usecase = "aggregator"
      Name = "Tg-ecs-stage-aggregator"
    }
    target_type = "instance"
  }
  "ecs-stage-auth" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-auth"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-author" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-author"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-avum" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-avum"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "literature"
      Environment = "stage"
      Type = "ec2"
      Usecase = "alum"
      Name = "Tg-ecs-stage-avum"
    }
    target_type = "instance"
  }
  "ecs-stage-blockbuster" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-blockbuster"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "blockbuster"
    }
    target_type = "instance"
  }
  "ecs-stage-blog" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-blog"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-carbon" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-carbon"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "literature"
      Environment = "stage"
      Type = "ec2"
      Usecase = "carbon"
      Name = "Tg-ecs-stage-carbon"
    }
    target_type = "instance"
  }
  "ecs-stage-carbon-app" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-carbon-app"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "literature"
      Environment = "stage"
      Type = "ec2"
      Usecase = "carbon app"
      Name = "Tg-ecs-stage-carbon-app"
    }
    target_type = "instance"
  }
  "ecs-stage-chronos" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-chronos"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "literature"
      Environment = "stage"
      Type = "ec2"
      Usecase = "continuation watch"
      Name = "Tg-eccs-stage-chronos"
    }
    target_type = "instance"
  }
  "ecs-stage-content" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-content"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-content-quality" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-content-quality"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "literature"
      Environment = "stage"
      Type = "ec2"
      Usecase = "content quality"
      Name = "Tg-ecs-stage-content-quality"
    }
    target_type = "instance"
  }
  "ecs-stage-content-review" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-content-review"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "literature"
      Environment = "stage"
      Type = "ec2"
      Usecase = "content review"
      Name = "Tg-ecs-stage-content-review"
    }
    target_type = "instance"
  }
  "ecs-stage-continue-reading" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-continue-reading"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "literature"
      Environment = "stage"
      Type = "target-group"
      Team = "discovery"
      Name = "continue-reading"
    }
    target_type = "instance"
  }
  "ecs-stage-coupon" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-coupon"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "Core Product"
      Environment = "stage"
      Type = "CloudWatch Alarm"
      Team = "Jedi"
      Name = "ecs-stage-coupon"
    }
    target_type = "instance"
  }
  "ecs-stage-dummy" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-dummy"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-erasure" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-erasure"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "literature"
      Environment = "Production"
      Type = "ec2"
      Team = "literature"
      Usecase = "ECS-Console-V2-Service-erasure-stage-amd-b16a8bfe"
      Name = "ECS-Console-V2-Service-erasure-stage-amd-b16a8bfe"
    }
    target_type = "instance"
  }
  "ecs-stage-feed" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-feed"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-follow" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-follow"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-fusion" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-fusion"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "literature"
      Environment = "stage"
      Type = "ec2"
      Usecase = "fusion"
      Name = "Tg-ecs-stage-fusion"
    }
    target_type = "instance"
  }
  "ecs-stage-graphql-gateway" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-graphql-gateway"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-gruite" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-gruite"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-gutenberg" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-gutenberg"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "literature"
      Environment = "stage"
      Type = "ec2"
      Usecase = "Gutenberg"
      Name = "Tg-ecs-stage-gutenberg"
    }
    target_type = "instance"
  }
  "ecs-stage-hermes" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-hermes"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "hermes"
    }
    target_type = "instance"
  }
  "ecs-stage-image" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-image"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-image-manager" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-image-manager"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-init" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-init"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-ip-acquisition" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-ip-acquisition"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "literature"
      Environment = "stage"
      Type = "target-group"
      Team = "jedi"
      Name = "ip-acquisition"
    }
    target_type = "instance"
  }
  "ecs-stage-khoj" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-khoj"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-library" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-library"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-literature-web" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-literature-web"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "ecs-stage-literature-web"
    }
    target_type = "instance"
  }
  "ecs-stage-live-stream" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-live-stream"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-mark8" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-mark8"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
    }
    target_type = "instance"
  }
  "ecs-stage-oasis" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-oasis"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-order" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-order"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "order"
    }
    target_type = "instance"
  }
  "ecs-stage-originator" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-originator"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-pag" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-pag"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-parcha" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-parcha"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-payment" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-payment"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "literature"
      Environment = "stage"
      Type = "ec2"
      Usecase = "payments"
      Name = "Tg-ecs-stage-payment"
    }
    target_type = "instance"
  }
  "ecs-stage-pratilipi" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-pratilipi"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-pwc" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-pwc"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "literature"
      Environment = "stage"
      Type = "ec2"
      Usecase = "pwc"
      Name = "Tg-ecs-stage-pwc"
    }
    target_type = "instance"
  }
  "ecs-stage-pwg" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-pwg"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-recommendation-next" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-recommendation-next"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-referral" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-referral"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "referral"
    }
    target_type = "instance"
  }
  "ecs-stage-report" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-report"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-seo-suite" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-seo-suite"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "literature"
      Environment = "stage"
      Type = "ec2"
      Usecase = "seo suite"
      Name = "Tg-ecs-stage-seo-suite"
    }
    target_type = "instance"
  }
  "ecs-stage-social" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-social"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-stats" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-stats"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-streak" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-streak"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "streak"
    }
    target_type = "instance"
  }
  "ecs-stage-subscription" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-subscription"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "subscription"
    }
    target_type = "instance"
  }
  "ecs-stage-user" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-user"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "core-stage-target-group"
    }
    target_type = "instance"
  }
  "ecs-stage-user-profiler" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-user-profiler"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "ecs-stage-user-profiler"
    }
    target_type = "instance"
  }
  "ecs-stage-wakanda" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-wakanda"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Vertical = "literature"
      Environment = "stage"
      Type = "target-group"
      Team = "platform"
      Name = "wakanda"
    }
    target_type = "instance"
  }
  "ecs-stage-wallet" = {
    alb_name = "stage-public-alb"
    deregistration_delay = 120
    health_check = {
      enabled = true
      healthy_threshold = 5
      interval = 30
      matcher = "200"
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      unhealthy_threshold = 2
    }
    name = "ecs-stage-wallet"
    port = 80
    protocol = "HTTP"
    protocol_version = "HTTP1"
    slow_start = 0
    stickiness = {
      enabled = false
      type = "lb_cookie"
      cookie_duration = 86400
    }
    tags = {
      Name = "wallet"
    }
    target_type = "instance"
  }
}

listener_rules = {
  "rule_mum-pub_0" = {
    listener_key = "public_https"
    priority     = 1
    conditions = [{
      path_pattern = ["/graphql*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-graphql-gateway"
    }]
  }
  "rule_mum-pub_1" = {
    listener_key = "public_https"
    priority     = 2
    conditions = [{
      host_header = ["web-stage.pratilipi.com"]
    }]
    actions = [{
      target_group_key = "ecs-stage-pwc"
    }]
  }
  "rule_mum-pub_2" = {
    listener_key = "public_https"
    priority     = 3
    conditions = [{
      host_header = ["stage.pratilipifm.com"]
    }]
    actions = [{
      target_group_key = "ecs-stage-graphql-gateway"
    }]
  }
  "rule_mum-pub_3" = {
    listener_key = "public_https"
    priority     = 4
    conditions = [{
      host_header = ["carbon-stage.pratilipi.com"]
    }]
    actions = [{
      target_group_key = "ecs-stage-carbon-app"
    }]
  }
  "rule_mum-pub_4" = {
    listener_key = "public_https"
    priority     = 5
    conditions = [{
      path_pattern = ["/api", "/api/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-pag"
    }]
  }
  "rule_mum-pub_5" = {
    listener_key = "public_https"
    priority     = 6
    conditions = [{
      host_header = ["stage*.pratilipi.com", "android-stage*.pratilipi.com", "stage*.pratilipi.com"]
    }]
    actions = [{
      target_group_key = "ecs-stage-pag"
    }]
  }
  "rule_mumbai-pvt_0" = {
    listener_key = "private_http"
    priority     = 1
    conditions = [{
      path_pattern = ["/coupon*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-coupon"
    }]
  }
  "rule_mumbai-pvt_1" = {
    listener_key = "private_http"
    priority     = 2
    conditions = [{
      path_pattern = ["/referral*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-referral"
    }]
  }
  "rule_mumbai-pvt_2" = {
    listener_key = "private_http"
    priority     = 3
    conditions = [{
      path_pattern = ["/streak*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-streak"
    }]
  }
  "rule_mumbai-pvt_3" = {
    listener_key = "private_http"
    priority     = 4
    conditions = [{
      path_pattern = ["/feed*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-feed"
    }]
  }
  "rule_mumbai-pvt_4" = {
    listener_key = "private_http"
    priority     = 5
    conditions = [{
      path_pattern = ["/live-stream/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-live-stream"
    }]
  }
  "rule_mumbai-pvt_5" = {
    listener_key = "private_http"
    priority     = 6
    conditions = [{
      path_pattern = ["/subscription*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-subscription"
    }]
  }
  "rule_mumbai-pvt_6" = {
    listener_key = "private_http"
    priority     = 7
    conditions = [{
      path_pattern = ["/parcha/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-parcha"
    }]
  }
  "rule_mumbai-pvt_7" = {
    listener_key = "private_http"
    priority     = 8
    conditions = [{
      path_pattern = ["/hermes*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-hermes"
    }]
  }
  "rule_mumbai-pvt_8" = {
    listener_key = "private_http"
    priority     = 9
    conditions = [{
      path_pattern = ["/order*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-order"
    }]
  }
  "rule_mumbai-pvt_9" = {
    listener_key = "private_http"
    priority     = 10
    conditions = [{
      path_pattern = ["/blockbuster*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-blockbuster"
    }]
  }
  "rule_mumbai-pvt_10" = {
    listener_key = "private_http"
    priority     = 11
    conditions = [{
      path_pattern = ["/wallet*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-wallet"
    }]
  }
  "rule_mumbai-pvt_11" = {
    listener_key = "private_http"
    priority     = 12
    conditions = [{
      path_pattern = ["/carbon*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-carbon"
    }]
  }
  "rule_mumbai-pvt_12" = {
    listener_key = "private_http"
    priority     = 13
    conditions = [{
      path_pattern = ["/fusion*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-fusion"
    }]
  }
  "rule_mumbai-pvt_13" = {
    listener_key = "private_http"
    priority     = 14
    conditions = [{
      path_pattern = ["/payment*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-payment"
    }]
  }
  "rule_mumbai-pvt_14" = {
    listener_key = "private_http"
    priority     = 15
    conditions = [{
      path_pattern = ["/chronos*", "/user_pratilipi*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-chronos"
    }]
  }
  "rule_mumbai-pvt_15" = {
    listener_key = "private_http"
    priority     = 16
    conditions = [{
      path_pattern = ["/auth/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-auth"
    }]
  }
  "rule_mumbai-pvt_16" = {
    listener_key = "private_http"
    priority     = 17
    conditions = [{
      path_pattern = ["/social/*", "/comment*", "/userpratilipi*", "/vote*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-social"
    }]
  }
  "rule_mumbai-pvt_17" = {
    listener_key = "private_http"
    priority     = 18
    conditions = [{
      path_pattern = ["/author-interviews/*", "/blogs/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-blog"
    }]
  }
  "rule_mumbai-pvt_18" = {
    listener_key = "private_http"
    priority     = 19
    conditions = [{
      path_pattern = ["/authors/recommendation", "/authors/recommendation/v2.0", "/stats/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-stats"
    }]
  }
  "rule_mumbai-pvt_19" = {
    listener_key = "private_http"
    priority     = 20
    conditions = [{
      path_pattern = ["/authors*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-author"
    }]
  }
  "rule_mumbai-pvt_20" = {
    listener_key = "private_http"
    priority     = 21
    conditions = [{
      path_pattern = ["/pratilipi/content*", "/content/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-content"
    }]
  }
  "rule_mumbai-pvt_21" = {
    listener_key = "private_http"
    priority     = 22
    conditions = [{
      path_pattern = ["/pratilipi*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-pratilipi"
    }]
  }
  "rule_mumbai-pvt_22" = {
    listener_key = "private_http"
    priority     = 23
    conditions = [{
      path_pattern = ["/ads*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-ads"
    }]
  }
  "rule_mumbai-pvt_23" = {
    listener_key = "private_http"
    priority     = 24
    conditions = [{
      path_pattern = ["/content-quality*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-content-quality"
    }]
  }
  "rule_mumbai-pvt_24" = {
    listener_key = "private_http"
    priority     = 25
    conditions = [{
      path_pattern = ["/image/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-image"
    }]
  }
  "rule_mumbai-pvt_25" = {
    listener_key = "private_http"
    priority     = 26
    conditions = [{
      path_pattern = ["/follows/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-follow"
    }]
  }
  "rule_mumbai-pvt_26" = {
    listener_key = "private_http"
    priority     = 27
    conditions = [{
      path_pattern = ["/library*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-library"
    }]
  }
  "rule_mumbai-pvt_27" = {
    listener_key = "private_http"
    priority     = 28
    conditions = [{
      path_pattern = ["/user-profiler/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-user-profiler"
    }]
  }
  "rule_mumbai-pvt_28" = {
    listener_key = "private_http"
    priority     = 29
    conditions = [{
      path_pattern = ["/user*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-user"
    }]
  }
  "rule_mumbai-pvt_29" = {
    listener_key = "private_http"
    priority     = 30
    conditions = [{
      path_pattern = ["/search/v*", "/recommendations/v2*", "/oasis/*", "/web/v1.0/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-oasis"
    }]
  }
  "rule_mumbai-pvt_30" = {
    listener_key = "private_http"
    priority     = 31
    conditions = [{
      path_pattern = ["/init/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-init"
    }]
  }
  "rule_mumbai-pvt_31" = {
    listener_key = "private_http"
    priority     = 32
    conditions = [{
      path_pattern = ["/originator*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-originator"
    }]
  }
  "rule_mumbai-pvt_32" = {
    listener_key = "private_http"
    priority     = 33
    conditions = [{
      path_pattern = ["/report/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-report"
    }]
  }
  "rule_mumbai-pvt_33" = {
    listener_key = "private_http"
    priority     = 34
    conditions = [{
      path_pattern = ["/recommendation-next/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-recommendation-next"
    }]
  }
  "rule_mumbai-pvt_34" = {
    listener_key = "private_http"
    priority     = 35
    conditions = [{
      path_pattern = ["/aggregator/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-aggregator"
    }]
  }
  "rule_mumbai-pvt_35" = {
    listener_key = "private_http"
    priority     = 36
    conditions = [{
      path_pattern = ["/khoj/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-khoj"
    }]
  }
  "rule_mumbai-pvt_36" = {
    listener_key = "private_http"
    priority     = 37
    conditions = [{
      path_pattern = ["/content-review*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-content-review"
    }]
  }
  "rule_mumbai-pvt_37" = {
    listener_key = "private_http"
    priority     = 38
    conditions = [{
      path_pattern = ["/image_manager/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-image-manager"
    }]
  }
  "rule_mumbai-pvt_38" = {
    listener_key = "private_http"
    priority     = 39
    conditions = [{
      path_pattern = ["/avum*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-avum"
    }]
  }
  "rule_mumbai-pvt_39" = {
    listener_key = "private_http"
    priority     = 40
    conditions = [{
      path_pattern = ["/gruite/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-gruite"
    }]
  }
  "rule_mumbai-pvt_40" = {
    listener_key = "private_http"
    priority     = 41
    conditions = [{
      path_pattern = ["/ip-acquisition/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-ip-acquisition"
    }]
  }
  "rule_mumbai-pvt_41" = {
    listener_key = "private_http"
    priority     = 42
    conditions = [{
      path_pattern = ["/gutenberg*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-gutenberg"
    }]
  }
  "rule_mumbai-pvt_42" = {
    listener_key = "private_http"
    priority     = 43
    conditions = [{
      path_pattern = ["/erasure/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-erasure"
    }]
  }
  "rule_mumbai-pvt_43" = {
    listener_key = "private_http"
    priority     = 44
    conditions = [{
      path_pattern = ["/continue-reading/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-continue-reading"
    }]
  }
  "rule_mumbai-pvt_44" = {
    listener_key = "private_http"
    priority     = 45
    conditions = [{
      path_pattern = ["/wakanda/*"]
    }]
    actions = [{
      target_group_key = "ecs-stage-wakanda"
    }]
  }
}

security_groups = {
  alb_public = {
    name        = "alb_public"
    description = "Public ALB SG"
    tags        = {
      Name        = "alb_public"
      Environment = "dev"
    }

    ingress = [
      {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]

    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
  alb_private = {
    name        = "alb_private"
    description = "Private ALB SG"
    tags        = {
      Name        = "alb_private"
      Environment = "dev"
    }

    ingress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["10.7.0.0/16"]
      }
    ]

    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
}

# ECS Cluster details

asg_max_size                      = 3
asg_min_size                      = 1
asg_desired_capacity              = 2
asg_instance_types                = ["t3.medium", "t3a.medium", "m5.large"]
asg_on_demand_base_capacity       = 1
asg_on_demand_percentage_above_base_capacity = 70
asg_spot_allocation_strategy      = "capacity-optimized"

ecs_clusters = {
    cluster1 = {
      name = "stage-amd"
      security_group_keys = ["ec2_private"]
      subnet_keys         = ["stage-private-subnet-1"]
      tags = {
        Name = "stage-amd"
      }
    }
    cluster2 = {
      name = "stage-worker"
      security_group_keys = ["ec2_private"]
      subnet_keys         = ["stage-private-subnet-1"]
      tags = {
        Name = "stage-worker"
      }
    }
}

ec2_security_groups = {
  ec2_private = {
    name        = "ec2_security_group"
    description = "Private EC2 SG"
    tags        = {
      Name        = "ec2_private_sg"
      Environment = "stage"
    }

    ingress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["10.7.0.0/16"]
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
}

image_id = "ami-06ef62a67be0325c9"

instance_type = "t3.medium"

#ECS service details..

services = [
  {
    service_name     = "hello-world-service"
    service_role     = "ecs-service-role-hello-world"
    ecs_cluster_name = "stage-amd"
    target_group_name    = "ecs-stage-literature-web"
    container_image  = "nginx:latest"
    container_port   = 80
    container_name   = "hello-world-service"
    cpu              = 512
    memory           = 1024
    desired_count    = 1
    custom_task_policies  = [
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = ["arn:aws:s3:::example-bucket"]
      }
    ]
  }
]

log_retention_in_days = 7

# SSH Key
public_key_path = "~/.ssh/stagekeys.pub"

# Tags
tags = {
  Environment = "stage"
  Project     = "stage-iac"
  ManagedBy   = "Terraform"
}

#DB details

db_instances = {
    stage-db = {
      db_instance_name = "stage-db"
      db_use_name_prefix      = true
      security_group_keys = ["stage-db"]
      db_subnet_keys         = ["stage-private-subnet-1", "stage-private-subnet-2"]
      db_allocated_storage    = 20
      db_engine               = "mysql"
      db_engine_version       = "8.4.4"
      db_instance_class       = "db.t3.micro"
      db_username             = "admin"
      db_password             = "securepassword123"
      db_name                 = "stagedb"
      create_db_subnet_group     = true
      db_subnet_group_name       = null
      db_subnet_group_description = "RDS subnet group"
      
      create_db_parameter_group  = true
      db_parameter_group_name    = null
      db_parameter_group_description = "RDS parameter group"
      db_parameter_group_parameters = [
        {
          name  = "max_connections"
          value = "100"
        }
      ]     
      create_db_option_group     = false
      db_option_group_name       = null
      db_option_group_options    = []      
      db_family             = "mysql8.4"
      db_major_engine_version  = "8.4"
      tags = {
        Name = "stage-db"
      }
    }
}

db_security_groups = {
  stage-db = {
    name        = "stage_db_sg"
    description = "Stage DB SG"
    tags        = {
      Name        = "stage_db_sg"
      Environment = "Stage"
    }

    ingress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["10.7.0.0/16"]
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
}

# Elasticache

elasticache_clusters = {
  stage-cache = {
    name                        = "stage-cache"
    node_type                   = "cache.t3.medium"
    engine                      = "valkey"
    engine_version              = "8.0"
    parameter_group_name        = "default.valkey8.cluster.on"
    port                        = 6379
    maintenance_window          = "mon:01:00-mon:02:00"
    snapshot_retention_limit    = 7
    snapshot_window             = "05:00-06:00"
    cluster_mode_enabled        = true
    num_node_groups             = 2
    replicas_per_node_group     = 1
    subnet_keys                 = ["stage-private-subnet-1", "stage-private-subnet-2"]
    security_group_keys         = ["stage-cache-sg"]
    create_log_group            = true
    log_group_retention_in_days = 14
    apply_immediately           = true
    at_rest_encryption_enabled  = true
    transit_encryption_enabled  = true
    tags = {
      Name        = "valkey-clustered"
      Environment = "stage"
    }
  }
}

elasticache_security_groups = {
  stage-cache-sg = {
    name        = "stage-cache-sg"
    description = "SG for clustered Valkey"
    ingress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["10.7.0.0/16"]
      }
    ]
    egress = []
    tags = {
      Name        = "stage-cache-sg"
      Environment = "stage"
    }
  }
}
