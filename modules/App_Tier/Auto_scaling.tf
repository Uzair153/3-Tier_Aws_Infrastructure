# App - EC2 Instance Security Group
resource "aws_security_group" "app_instance_sg" {
  name        = var.app_instance_SG_name
  description = "Allowing requests to the app servers"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_app.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-server-security-group"
  }
}

# App - Launch Template
resource "aws_launch_template" "app_launch_template" {
  name_prefix            = var.app_name_prefix
  image_id               = var.app_ami
  instance_type          = var.app_instance_type
  vpc_security_group_ids = [aws_security_group.app_instance_sg.id]
}

# App - Auto Scaling Group
resource "aws_autoscaling_group" "app_asg" {
  desired_capacity    = var.app_desired_capacity
  max_size            = var.app_max_size
  min_size            = var.app_min_size
  target_group_arns   = [aws_lb_target_group.app_target_group.arn]
  vpc_zone_identifier = var.app_vpc_zone_identifier
  launch_template {
    id      = aws_launch_template.app_launch_template.id
    version = "$Latest"
  }
}

// Outputs

output "app_instance_sg_id" {
  value = aws_security_group.app_instance_sg.id
}