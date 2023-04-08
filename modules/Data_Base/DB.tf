# DB - Security Group
resource "aws_security_group" "db_security_group" {
  name = var.db_SG_name

  description = "RDS postgres server"
  vpc_id      = var.vpc_id

  # Only postgres in
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.db_security_groups]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# DB - Subnet Group
resource "aws_db_subnet_group" "db_subnet" {
  name       = "db-subnet"
  subnet_ids = var.db_subnets_ids

  tags = {
    Name = "My DB subnet group"
  }
}


# DB - RDS Instance
resource "aws_db_instance" "db_postgres" {
  allocated_storage       = var.allocated_storage
  backup_retention_period = var.backup_retention_period
  db_subnet_group_name    = aws_db_subnet_group.db_subnet.name
  engine                  = var.engine
  engine_version          = var.engine_version #"12.4"
  identifier              = var.identifier
  instance_class          = var.instance_class
  multi_az                = false
  db_name                 = var.db_name
  username                = var.username #"dbadmin"
  password                = var.password #"set-your-own-password!"
  port                    = var.db_port
  publicly_accessible     = false
  storage_encrypted       = true
  storage_type            = var.db_storage_type
  vpc_security_group_ids  = [aws_security_group.db_security_group.id]
  skip_final_snapshot     = true
}
