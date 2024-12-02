module "vpc" {
    source = "terraform-aws-modules/vpc/aws"

    name = "vpc-dev"
    cidr = "10.21.0.0/16"

    azs             = ["ap-northeast-2a", "ap-northeast-2c"]
    public_subnets  = ["10.21.0.0/24", "10.21.1.0/24"]
    private_subnets = ["10.21.32.0/24", "10.21.33.0/24"]
    intra_subnets   = ["10.21.64.0/24", "10.21.65.0/24"]

    public_subnet_tags = {
      "kubernetes.io/cluster/dev" = "shared"
      "kubernetes.io/role/elb" = "1"
    }

    private_subnet_tags = {
      "kubernetes.io/cluster/dev" = "shared"
      "kubernetes.io/role/internal-elb" = "1"
    }

    enable_nat_gateway = true
    single_nat_gateway = false
    one_nat_gateway_per_az = true

    tags = {
        Terraform = "true"
        Environment = "dev"
        Creator = "kyeongjun.dev"
    }
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "public_subnets" {
  value = "${module.vpc.public_subnets}"
}

output "private_subnets" {
  value = "${module.vpc.private_subnets}"
}

output "intra_subnets" {
  value = "${module.vpc.intra_subnets}"
}