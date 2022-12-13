




module "vpc" {
  source              = "terraform-aws-modules/vpc/aws"
  version             = "~> 3.14"
  name                = format("%s-vpc", local.prefix)
  cidr                = "10.1.0.0/16"
  azs                 = [format("%sa", var.region), format("%sb", var.region), format("%sc", var.region)]
  public_subnets      = ["10.1.0.0/22", "10.1.4.0/22", "10.1.8.0/22"]
  private_subnets     = ["10.1.12.0/22", "10.1.16.0/22", "10.1.20.0/22"]
  enable_dhcp_options = true
}
locals {
  prefix="beknazar"
}

