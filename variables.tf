//   *********************************************VPC*********************************************
// variables for VPC
variable "vpc_cidr_block" {
  description = "Main VPC CIDR Block"
}

variable "az_public_subnet" {
  type = map(string)
}

variable "az_private_subnet" {
  type = map(string)
}

variable "az_database_subnet" {
  type = map(string)
}

variable "availability_zones" {
  type = list(string)
}
variable "vpc_tag" {
  type = string
}
variable "IGW_tag" {
  type = string
}
variable "route_cidr" {
  type = string
}
variable "RT_tag" {
  type = string
}

//   *********************************************WEB TIER*********************************************
// Variables for Web_Tier load_balancer

variable "lb_name" {
  type = string
}
variable "alb_SG-name" {
  type = string
}
variable "ports" {
  type = list(number)
}
variable "SG_tag" {
  type = string
}
variable "listner_port" {
  type = string
}
variable "listner_protocol" {
  type = string
}
variable "TG_name" {
  type = string
}
variable "TG_port" {
  type = string
}
variable "TG_protocol" {
  type = string
}

# Variables for Web_Tier Auto scaling Group

variable "web_SG_name" {
  type = string
}
variable "key_name" {
  type = string
}
variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "name_prefix" {
  type = string
}
variable "max_size" {
  type = string
}
variable "min_size" {
  type = string
}
variable "desired_capacity" {
  type = string
}

//   *********************************************APP TIER*********************************************

// variables for App_Tier load balancer
variable "app_alb_SG_name" {
  type = string
}
variable "app_alb_name" {
  type = string
}
variable "app_listener_port" {
  type = string
}
variable "app_listener_protocol" {
  type = string
}
variable "app_TG_name" {
  type = string
}
variable "app_TG_port" {
  type = string
}
variable "app_TG_protocol" {
  type = string
}


// variables for App_Tier auto scaling

variable "app_instance_SG_name" {
  type = string
}
variable "app_ami" {
  type = string
}
variable "app_instance_type" {
  type = string
}
variable "app_name_prefix" {
  type = string
}
variable "app_desired_capacity" {
  type = string
}
variable "app_max_size" {
  type = string
}
variable "app_min_size" {
  type = string
}

//   *********************************************THE DB*********************************************

// Data Base

variable "db_SG_name" {
  type = string
}
variable "db_name" {
  type = string
}
variable "username" {
  type = string
}
variable "password" {
  type = string
}
variable "db_port" {
  type = string
}
variable "allocated_storage" {
  type = string
}
variable "backup_retention_period" {
  type = string
}
variable "engine" {
  type = string
}
variable "engine_version" {
  type = string
}
variable "identifier" {
  type = string
}
variable "instance_class" {
  type = string
}
variable "db_storage_type" {
  type = string
}