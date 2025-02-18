resource "aws_ecs_task_definition" "my_task" {
  family                   = "my-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = "256"
  memory                   = "256"
  
  container_definitions = jsonencode([{
    name      = "my-app-container"
    image     = "ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/my-app:latest"
    cpu       = 256
    memory    = 256
    essential = true
    portMappings = [{
      containerPort = 3000
      hostPort      = 3000
      protocol      = "tcp"
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/my-app"
        awslogs-region        = "us-east-1"
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}
