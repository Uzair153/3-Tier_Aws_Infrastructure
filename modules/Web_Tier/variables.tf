// Variables for load_balancer

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
variable "lb_subnet" {
  type = list(string)
}
variable "vpc_id" {
  type = string
}

# Variables for Auto scaling

variable "web_SG_name" {
  type = string
}
variable "vpc_zone_identifier" {
  type    = list(string)
  default = []
}
variable "key" {
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


