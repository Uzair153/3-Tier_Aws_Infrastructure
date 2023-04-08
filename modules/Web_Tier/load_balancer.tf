//Web - Application Load Balancer
resource "aws_lb" "app_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.lb_subnet
}

# Web - ALB Security Group
resource "aws_security_group" "alb_sg" {
  name        = var.alb_SG-name
  description = "Allowing HTTP requests to the application load balancer"
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.SG_tag
  }
}

# Web - Listener
resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = var.listner_port
  protocol          = var.listner_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_target_group.arn
  }
}

# Web - Target Group
resource "aws_lb_target_group" "web_target_group" {
  name     = var.TG_name
  port     = var.TG_port
  protocol = var.TG_protocol
  vpc_id   = var.vpc_id

  health_check {
    port     = 80
    protocol = "HTTP"
  }
}