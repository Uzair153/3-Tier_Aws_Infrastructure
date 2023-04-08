variable "vpc_id" {
  type = string
}
variable "db_SG_name" {
  type = string
}
variable "db_subnets_ids" {
  type = list(string)
}
variable "db_security_groups" {
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