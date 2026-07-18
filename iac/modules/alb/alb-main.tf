
resource "aws_lb" "this" {
  name     = "${var.project_name}-${var.environment}-alb"
  internal = false

  load_balancer_type = "application"

  subnets         = var.public_subnet_ids
  security_groups = [var.alb_security_group_id]


  enable_deletion_protection = false

  tags = {
    Name        = "${var.project_name}-${var.environment}-alb"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "this" {
  name        = "${var.project_name}-${var.environment}-tg"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip" # for EKS



  health_check {
    enabled             = true
    path                = var.health_path
    protocol            = "HTTP"
    port                = "traffic-port"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name        = "${var.project_name}-${var.environment}-tg"
    Environment = var.environment
  }

}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn

  }
}


