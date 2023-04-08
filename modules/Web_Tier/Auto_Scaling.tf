

# Web - EC2 Instance Security Group
resource "aws_security_group" "web_instance_sg" {
  name        = var.web_SG_name
  description = "Allowing requests to the web servers"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-server-security-group"
  }
}
// creating key-pair for ssh
resource "aws_key_pair" "test-key" {
  key_name   = var.key_name
  public_key = var.key
}
# Web - Launch Template
resource "aws_launch_template" "web_launch_template" {
  name_prefix   = var.name_prefix
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.test-key.key_name
}

# Web - Auto Scaling Group
resource "aws_autoscaling_group" "web_asg" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  target_group_arns   = [aws_lb_target_group.web_target_group.arn]
  vpc_zone_identifier = var.vpc_zone_identifier

  launch_template {
    id      = aws_launch_template.web_launch_template.id
    version = "$Latest"
  }
}

//Outputs

output "web_instance_sg_id" {
  value = aws_security_group.web_instance_sg.id
}