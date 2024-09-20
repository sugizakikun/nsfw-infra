data "aws_iam_policy" "ecs_task_execution_role_policy" {
    arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "ecs_task_execution" {
    source_json = data.aws_iam_policy.ecs_task_execution_role_policy.policy

    statement {
        effect      = "Allow"
        actions     = ["ssm:GetParameters", "kms:Decrypt"]
        resources   = ["*"]
    }
}

module "ecs_task_execution_role" {
    source      = "./iam_role"
    name        = "ecs-task-execution"
    identifier  = "ecs-tasks.amazonaws.com"
    policy      = data.aws_iam_policy_document.ecs_task_execution.json
}