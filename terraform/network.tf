resource "aws_vpc" "epam-vpc" {
  cidr_block           = "172.32.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  enable_classiclink   = false
  instance_tenancy     = "default"

  tags = {
    "Name" = "epam-vpc"
  }
}

resource "aws_subnet" "epam-subnet-public-1" {
  vpc_id                  = aws_vpc.epam-vpc.id
  cidr_block              = "172.32.0.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"

  tags = {
    "Name" = "epam-subnet-public-1"
  }
}

resource "aws_subnet" "epam-subnet-public-2" {
  vpc_id                  = aws_vpc.epam-vpc.id
  cidr_block              = "172.32.16.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1b"

  tags = {
    "Name" = "epam-subnet-public-2"
  }
}

resource "aws_subnet" "epam-subnet-public-3" {
  vpc_id                  = aws_vpc.epam-vpc.id
  cidr_block              = "172.32.32.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1c"

  tags = {
    "Name" = "epam-subnet-public-3"
  }
}

resource "aws_internet_gateway" "epam-igw" {
  vpc_id = aws_vpc.epam-vpc.id

  tags = {
    "Name" = "epam-igw"
  }
}

resource "aws_route_table" "epam-public-crt" {
  vpc_id = aws_vpc.epam-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.epam-igw.id
  }

  tags = {
    Name = "epam-public-crt"
  }
}

resource "aws_route_table_association" "epam-crta-public-subnet-1" {
  subnet_id      = aws_subnet.epam-subnet-public-1.id
  route_table_id = aws_route_table.epam-public-crt.id
}

resource "aws_route_table_association" "epam-crta-public-subnet-2" {
  subnet_id      = aws_subnet.epam-subnet-public-2.id
  route_table_id = aws_route_table.epam-public-crt.id
}

resource "aws_route_table_association" "epam-crta-public-subnet-3" {
  subnet_id      = aws_subnet.epam-subnet-public-3.id
  route_table_id = aws_route_table.epam-public-crt.id
}

resource "aws_security_group" "epam-all" {
  vpc_id = aws_vpc.epam-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "epam-all"
  }
}