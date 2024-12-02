data "terraform_remote_state" "remote_resource" {
  backend = "local"
  config = {
    path = "../03-cluster/terraform.tfstate"
  }
}

# cluster autoscaler role
resource "aws_iam_role" "eks_cluster_autoscaler_role" {
    name = "clusterAutoscalerRole"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "${data.terraform_remote_state.remote_resource.outputs.eks_cluster_oidc_provider_arn}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "${data.terraform_remote_state.remote_resource.outputs.eks_cluster_oidc_provider}:aud": "sts.amazonaws.com",
                    "${data.terraform_remote_state.remote_resource.outputs.eks_cluster_oidc_provider}:sub": "system:serviceaccount:kube-system:cluster-autoscaler"
                }
            }
        }
    ]
}
POLICY
}

output "eks_cluster_autoscaler_role_arn" {
    value       = "${aws_iam_role.eks_cluster_autoscaler_role.arn}"
}

resource "aws_iam_policy" "eks_cluster_autoscaler_policy" {
  name        = "clusterAutoscalerPolicy"
  path        = "/"
  description = "Used for Cluster Autoscaler"

  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeScalingActivities",
        "ec2:DescribeImages",
        "ec2:DescribeInstanceTypes",
        "ec2:DescribeLaunchTemplateVersions",
        "ec2:GetInstanceTypesFromInstanceRequirements",
        "eks:DescribeNodegroup"
      ],
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup"
      ],
      "Resource": ["*"]
    }
  ]
})
}

resource "aws_iam_role_policy_attachment" "eks_cluster_autoscaler_policy" {
    policy_arn = "${aws_iam_policy.eks_cluster_autoscaler_policy.arn}"
    role       = "${aws_iam_role.eks_cluster_autoscaler_role.name}"
}