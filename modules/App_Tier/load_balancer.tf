# App - ALB Security Group
resource "aws_security_group" "alb_app" {
  name        = var.app_alb_SG_name
  description = "Allowing HTTP requests to the app tier application load balancer"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.app_instance_security_group]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-app-security-group"
  }
}

# App - Application Load Balancer
resource "aws_lb" "app_app_lb" {
  name               = var.app_alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_app.id]
  subnets            = var.app_lb_subnets
}

# App - Listener
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_app_lb.arn
  port              = var.app_listener_port
  protocol          = var.app_listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_target_group.arn
  }
}

# App - Target Group
resource "aws_lb_target_group" "app_target_group" {
  name     = var.app_TG_name
  port     = var.app_TG_port
  protocol = var.app_TG_protocol
  vpc_id   = var.vpc_id

  health_check {
    port     = 80
    protocol = "HTTP"
  }
}

