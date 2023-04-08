terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.61.0"
    }
  }
}

// Run = terraform plan -var-file=env/dev.tfvars

# Configuration options
provider "aws" {
  region = "ap-south-1"
}
//*********************************************VPC*********************************************
module "VPC" {
  source             = "./modules/VPC"
  vpc_cidr_block     = var.vpc_cidr_block
  vpc_tag            = var.vpc_tag
  az_public_subnet   = var.az_public_subnet
  az_private_subnet  = var.az_private_subnet
  az_database_subnet = var.az_database_subnet
  availability_zones = var.availability_zones
  route_cidr         = var.route_cidr
  RT_tag             = var.RT_tag
  IGW_tag            = var.IGW_tag
}
// *********************************************WEB_TIER*********************************************
module "Web_Tier" {
  source = "./modules/Web_Tier"
  // load_balancer 
  lb_name          = var.lb_name
  lb_subnet        = module.VPC.public_subnet_id
  alb_SG-name      = var.alb_SG-name
  vpc_id           = module.VPC.vpc_id
  ports            = var.ports
  SG_tag           = var.SG_tag
  listner_port     = var.listner_port
  listner_protocol = var.listner_protocol
  TG_name          = var.TG_name
  TG_port          = var.TG_port
  TG_protocol      = var.TG_protocol
  // Auto_scaling_group
  web_SG_name         = var.web_SG_name
  key                 = file("${path.module}/key-tf.pub")
  key_name            = var.key_name
  ami                 = var.ami
  instance_type       = var.instance_type
  vpc_zone_identifier = module.VPC.public_subnet_id
  name_prefix         = var.name_prefix
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity

}

// *********************************************APP TIER*********************************************

module "App_Tier" {
  source = "./modules/App_Tier"
  //load balancer
  app_alb_name                = var.app_alb_name
  app_alb_SG_name             = var.app_alb_SG_name
  app_instance_security_group = module.Web_Tier.web_instance_sg_id
  app_lb_subnets              = module.VPC.private_subnet_id
  app_listener_port           = var.app_listener_port
  app_listener_protocol       = var.app_listener_protocol
  app_TG_name                 = var.app_TG_name
  app_TG_port                 = var.app_TG_port
  app_TG_protocol             = var.app_TG_protocol
  vpc_id                      = module.VPC.vpc_id
  //Auto_Scaling
  app_instance_SG_name    = var.app_instance_SG_name
  app_ami                 = var.app_ami
  app_instance_type       = var.app_instance_type
  app_name_prefix         = var.app_name_prefix
  app_desired_capacity    = var.app_desired_capacity
  app_max_size            = var.app_max_size
  app_min_size            = var.app_min_size
  app_vpc_zone_identifier = module.VPC.private_subnet_id
}

//   *********************************************THE DB*********************************************


module "Data_Base" {
  source                  = "./modules/Data_Base"
  db_subnets_ids          = module.VPC.db_subnet_id
  vpc_id                  = module.VPC.vpc_id
  db_security_groups      = module.App_Tier.app_instance_sg_id
  db_SG_name              = var.db_SG_name
  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  db_port                 = var.db_port
  allocated_storage       = var.allocated_storage
  backup_retention_period = var.backup_retention_period
  engine                  = var.engine
  engine_version          = var.engine_version
  identifier              = var.identifier
  instance_class          = var.instance_class
  db_storage_type         = var.db_storage_type
}
