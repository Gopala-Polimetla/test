provider "aws" {
  region = var.region
}

resource "aws_vpc" "Demo_VPC" {
  cidr_block = var.vpc_cidr_block
  tags = {
     Name = "${var.environment}-VPC"
   }
}

module "My_Subnet" {
  source = "./modules/subnet"
  Subnet_cidr_block = var.Subnet_cidr_block
  environment = var.environment
  vpc_id = aws_vpc.Demo_VPC.id
}

module "My_Web_server" {
  source = "./modules/webserver"
  vpc_id = aws_vpc.Demo_VPC.id
  public_key_location = var.public_key_location
  subnet_id = module.My_Subnet.subnet.id
  environment = var.environment
}
