resource "aws_eks_addon" "vpc_cni" {
  cluster_name = var.cluster_name

  addon_name    = "vpc-cni"
  addon_version = var.vpc_cni_version

  resolve_conflicts_on_update = "OVERWRITE"
}