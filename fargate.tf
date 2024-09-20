provider "aws" {
    region = "us-east-1"
}

# ECSクラスタの定義
resource "aws_ecs_cluster" "nsfw_cluster" {
    name = "nsfw_api_cluster"
}

# ECSタスクの定義
resource "aws_ecs_task_definition" "nsfw_task" {
    family                      = "nsfw-api-container"
    cpu                         = "256"
    memory                      = "512"
    network_mode                = "awsvpc"
    requires_compatibilities    = ["FARGATE"]
    container_definitions       = file("./container_definition.json")
    execution_role_arn          = module.ecs_task_execution_role.iam_role_arn
}

# ECSサービスの定義
resource "aws_ecs_service" "nsfw_service" {
    name                                = "nsfw_api_service"
    cluster                             = aws_ecs_cluster.nsfw_cluster.arn
    task_definition                     = aws_ecs_task_definition.nsfw_task.arn
    desired_count                       = 1
    launch_type                         = "FARGATE"
    platform_version                    = "1.3.0"
    
    network_configuration {
        assign_public_ip = true
        security_groups = [aws_security_group.nsfw_api_sg.id]

        subnets = var.public_subnet_ids
    }

    load_balancer {
        target_group_arn    = aws_lb_target_group.ecs_tg.arn
        container_name      = "nsfw-api-container"
        container_port      = 5000
    }

    lifecycle {
        ignore_changes = [task_definition]
    }
}

output "ecs_service_info" {
  value       = aws_ecs_service.nsfw_service
}



