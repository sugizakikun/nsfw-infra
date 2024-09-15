# Elastic IP
resource "aws_eip" "nlb" {
    tags = {
        Name = "elastic ip"
    }
}


# NLBのターゲットグループを作成
resource "aws_lb_target_group" "ecs_tg" {
    target_type = "ip"
    name        = "ecs-target-group"
    port        = 5000
    protocol    = "TCP"
    vpc_id      = var.vpc_id

    health_check {
        port               = "traffic-port"
        protocol           = "TCP"
    }
}

# NLBを作成
resource "aws_lb" "nlb" {
    name               = "ecs-nlb"
    internal           = false  # パブリック NLB の場合は false
    load_balancer_type = "network"
    ip_address_type    = "ipv4"
    idle_timeout       = 60

    subnet_mapping {
        subnet_id       = var.public_subnet_ids[0]
        allocation_id   = aws_eip.nlb.id
    }
}

# リスナーを作成
resource "aws_lb_listener" "nlb_listener" {
    load_balancer_arn = aws_lb.nlb.arn
    port              = 5000
    protocol          = "TCP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.ecs_tg.arn
    }
}

output "nlb" {
    value = aws_eip.nlb
}