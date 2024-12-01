module "vpc" {
    source = "terraform-aws-modules/vpc/aws"

    name = "vpc-dev"
    cidr = "192.168.0.0/16"

    azs             = ["ap-northeast-2a", "ap-northeast-2c"]
    public_subnets  = ["192.168.1.0/24", "192.168.2.0/24"]
    private_subnets = ["192.168.3.0/24", "192.168.4.0/24"]
    intra_subnets   = ["192.168.5.0/24", "192.168.6.0/24"]

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