// variables for load balancer
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
variable "vpc_id" {
  type = string
}
variable "app_lb_subnets" {
  type = list(string)
}
variable "app_instance_security_group" {
  type = string
}

// variables for auto scaling

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
variable "app_vpc_zone_identifier" {
  type = list(string)
}