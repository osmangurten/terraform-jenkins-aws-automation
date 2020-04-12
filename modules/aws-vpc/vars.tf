# Labels

variable "namespace" {
  type        = "string"
  default     = ""
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}
variable "name" {
  type        = "string"
  default     = ""
  description = "Solution name, e.g. `app` or `jenkins`"
}
variable "stage" {
  type        = "string"
  default     = ""
  description = "Stage, e.g. 'prod', 'staging', 'dev'"
}
variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}


# Nat Gate Ways
variable "total-nat-gateway-required" {
  default = "1"
}
# Internet Gateways Tags

variable "internet-gateway-name" {
  description = "Additional tags for the internet gateway"
  default     = "igw"
}

# FETCH AZS From Region

data "aws_availability_zones" "azs" {}

# VPC

variable "enabled" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  default = "default"
}
variable "enable_dns_support" {
  default = true
}
variable "enable_dns_hostnames" {
  default = true
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}


# VPC Cidr Block

variable "vpc_cidr" {
  default = ""
}
# VPC Public Subnets Cidr Block List

variable "vpc-public-subnet-cidr" {
  type = "list"
}
# Public Subnet Tags

variable "map_public_ip_on_launch" {
  default = "true"
}
variable "public-subnets-name" {
  default = "public-subnets"
}
variable "public-subnet-routes-name" {
  default = "public-routes"
}

# VPC Private Subnets Cidr Block List

variable "vpc-private-subnet-cidr" {
  type = "list"
}


# VPC Location
variable "vpc-location" {
  default = ""
}

# Database Subnets

# list of database subnets

variable "create_database_subnet_group" {
  type    = bool
  default = false
}

variable "vpc-database_subnets-cidr" {
  type    = list(string)
  default = []
}
