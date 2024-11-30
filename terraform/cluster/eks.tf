data "terraform_remote_state" "remote_resource" {
  backend = "local"
  config = {
    path = "../share/terraform.tfstate"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"

  cluster_name    = "dev"
  cluster_version = "1.31"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns                = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id                   = "${data.terraform_remote_state.remote_resource.outputs.vpc_id}"
  subnet_ids               = "${data.terraform_remote_state.remote_resource.outputs.private_subnets}"
  control_plane_subnet_ids = "${data.terraform_remote_state.remote_resource.outputs.intra_subnets}"

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large"]
  }

  eks_managed_node_groups = {
    example = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["m5.xlarge"]

      min_size     = 1
      max_size     = 4
      desired_size = 1
    }
  }

  tags = {
        Terraform = "true"
        Environment = "dev"
        Creator = "kyeongjun.dev"
    }
}

output "eks_cluster_oidc_provider" {
  value = "${module.eks.oidc_provider}"
}