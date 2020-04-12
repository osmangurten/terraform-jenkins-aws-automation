# labels

module "label" {
  source     = "../terraform-label"
  namespace  = var.namespace
  name       = var.name
  stage      = var.stage
  delimiter  = var.delimiter
  attributes = var.attributes
  tags       = var.tags
}

# Var değişkenleri source module içerisinde kullanıyor.
# Böylece var değişkenlerini terraform label içinde kullanıp geri dönüyor.
# Module bir arayüz gibi çalışıyor.


# Creating VPC

resource "aws_vpc" "my_vpc" {
  count                = var.enabled ? 1 : 0
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    module.label.tags,
    map(
      "Location", var.vpc-location
    ),
    map(
      "Environemt", var.stage
    )
  )
}


# Public Subnets

resource "aws_subnet" "public-subnets" {
  count                   = var.enabled && length(var.vpc-public-subnet-cidr) > 0 ? length(var.vpc-public-subnet-cidr) : 0
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  cidr_block              = var.vpc-public-subnet-cidr[count.index]
  vpc_id                  = aws_vpc.my_vpc[0].id
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "${module.label.namespace}-${module.label.stage}-${var.public-subnets-name}-${count.index + 1}"
  }
}

# Creating an Internet Gateway

resource "aws_internet_gateway" "igw" {
  count  = var.enabled && length(var.vpc-public-subnet-cidr) > 0 ? 1 : 0
  vpc_id = aws_vpc.my_vpc[0].id

  tags = {

    Name = "${module.label.namespace}-${module.label.stage}-${var.internet-gateway-name}"
  }
}

# Public Routes

resource "aws_route_table" "public-routes" {
  vpc_id = aws_vpc.my_vpc[0].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }
  tags = {
    Name = "${module.label.namespace}-${module.label.stage}-${var.public-subnet-routes-name}"
  }
}

# Associate/Link Public-Route With Public-Subnets

resource "aws_route_table_association" "public-association" {
  count          = var.enabled && length(var.vpc-public-subnet-cidr) > 0 ? length(var.vpc-public-subnet-cidr) : 0
  route_table_id = aws_route_table.public-routes.id
  subnet_id      = aws_subnet.public-subnets.*.id[count.index]
  # It is multiple subnets. We access them using *. This returns back list of subnet IDs
  #From that list we should access one subnet at a time in the loop using [count.index]
}
