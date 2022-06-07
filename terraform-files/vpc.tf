locals {
   private_subnets = [for i in range(1,4): cidrsubnet(var.vpc_cidr, 8, i)]
   public_subnets  = [for i in range(4,7): cidrsubnet(var.vpc_cidr, 8, i)]
   azs             = [for c in ["a","b","c"]: format("%s%s", var.region, c)]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  tags = {
      Name = var.vpc_name
  }
}

resource "aws_security_group" "worker_group" {
  name_prefix = "worker-group-additional"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "10.0.0.0/8"
    ]
  }

  tags = {
      Name = "worker-group-additional"
  }
}
