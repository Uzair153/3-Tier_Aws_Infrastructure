
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