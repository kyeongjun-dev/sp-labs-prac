resource "kubernetes_service_account" "aws_loadbalancer_controller" {
  metadata {
    name      = "cluster-autoscaler"
    namespace = "kube-system"

    annotations = {
      "eks.amazonaws.com/role-arn" = "${aws_iam_role.eks_cluster_autoscaler_role.arn}"
    }
  }
}