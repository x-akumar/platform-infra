resource "aws_eks_addon" "coredns" {
  cluster_name = var.cluster_name

  addon_name    = "coredns"
  addon_version = var.coredns_version

  resolve_conflicts_on_update = "OVERWRITE"
}