# Require TF version to most recent
terraform {
  required_version = "~> 0.12.8"
}

# Download any stable version in AWS provider of 2.19.0 or higher in 2.19 train
provider "aws" {
  version = "~> 2.27.0"
  region  = "us-east-1"
  backend "s3" {
    bucket         = "cl-ue1-al-terraform-tfstate"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "aws-locks"
    encrypt        = true
  }
}

# Build the VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "10.1.0.0/16"
  instance_tenancy     = "default"

  tags = {
    Name      = "Vpc"
    Terraform = "true"
  }
}

# Build route table 1
resource "aws_route_table" "route_table1" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "RouteTable1"
    Terraform = "true"
  }
}

# Build route table 2
resource "aws_route_table" "route_table2" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "RouteTable2"
    Terraform = "true"
  }
}
