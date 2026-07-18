

resource "aws_cloudwatch_log_group" "ecs_log" {
  name              = "/ecs/${var.project_name}-${var.environment}"
  retention_in_days = 7

  tags = {
    Name        = "${var.project_name}-${var.environment}-ecs-log"
    Environment = var.environment
  }
}

resource "aws_ecs_cluster" "this" {
  name = "${var.project_name}-${var.environment}-ecs-cluster"


  tags = {
    Name        = "${var.project_name}-${var.environment}-ecs-cluster"
    Environment = var.environment
  }
}




resource "aws_ecs_service" "ecs_service" {
  name            = "${var.project_name}-${var.environment}-ecs-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  health_check_grace_period_seconds = 60

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.app_port
  }

  depends_on = [
    aws_iam_role_policy_attachment.task_execution_role_policy,
    aws_iam_role_policy.read_db_secret
  ]

  tags = {
    Name        = "${var.project_name}-${var.environment}-ecs-service"
    Environment = var.environment
  }
}

data "aws_iam_policy_document" "ecs_task_execution_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }

}
resource "aws_iam_role" "task_execution_role" {
  name               = "${var.project_name}-${var.environment}-ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assume_role.json
}

data "aws_iam_policy_document" "read_db_secret" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue"
    ]

    resources = [
      var.db_password_secret_arn
    ]
  }
}

resource "aws_iam_role_policy" "read_db_secret" {
  name   = "${var.project_name}-${var.environment}-read-db-secret"
  role   = aws_iam_role.task_execution_role.id
  policy = data.aws_iam_policy_document.read_db_secret.json
}

resource "aws_iam_role" "task_role" {
  name               = "${var.project_name}-${var.environment}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assume_role.json
}


resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "${var.project_name}-${var.environment}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu
  memory                   = var.task_memory


  execution_role_arn = aws_iam_role.task_execution_role.arn
  task_role_arn      = aws_iam_role.task_role.arn


  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.image_uri
      essential = true

      portMappings = [
        {
          containerPort = var.app_port
          hostPort      = var.app_port
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "PORT"
          value = tostring(var.app_port)
        },
        {
          name  = "DB_HOST"
          value = var.db_host
        },
        {
          name  = "DB_PORT"
          value = tostring(var.db_port)
        },
        {
          name  = "DB_NAME"
          value = var.db_name
        },
        {
          name  = "DB_USER"
          value = var.db_username
        },
        {
          name  = "BUILD_TAG"
          value = var.build_tag
        },
        {
          name  = "DB_SSL"
          value = "true"
        }
      ]

      secrets = [
        {
          name      = "DB_PASSWORD"
          valueFrom = var.db_password_secret_arn
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_log.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  tags = {
    Name        = "${var.project_name}-${var.environment}-task"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "task_execution_role_policy" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
