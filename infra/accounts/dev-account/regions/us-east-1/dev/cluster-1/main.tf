module "vpc" {
  source          = "../../../../../../../modules/vpc"
  vpc_cidr        = var.vpc_cidr
  tags            = var.tags
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  cluster_name    = var.cluster_name
}

module "iam" {
  source       = "../../../../../../../modules/iam"
  cluster_name = var.cluster_name
}

module "eks" {
  source = "../../../../../../../modules/eks"

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version

  cluster_role_arn    = module.iam.eks_cluster_role_arn
  node_group_role_arn = module.iam.node_group_role_arn

  private_subnet_ids = module.vpc.private_subnet_ids

  instance_types = var.instance_types
  desired_size   = var.desired_size
  min_size       = var.min_size
  max_size       = var.max_size

  tags = var.tags
}

module "addons" {
  source = "../../../../../../../modules/addons"

  cluster_name = module.eks.cluster_name


  coredns_version = var.coredns_version

  kube_proxy_version = var.kube_proxy_version

  vpc_cni_version = var.vpc_cni_version
}

module "oidc" {
  source = "../../../../../../../modules/oidc"

  oidc_issuer_url = module.eks.oidc_issuer_url
}


module "irsa" {
  source = "../../../../../../../modules/irsa"

  oidc_provider_arn = module.oidc.oidc_provider_arn
  oidc_issuer_url   = module.eks.oidc_issuer_url
}


module "platform" {
  source = "../../../../../../../modules/platform"

  cluster_name = module.eks.cluster_name

  aws_region = var.aws_region
  vpc_id     = module.vpc.vpc_id

  aws_lbc_role_arn            = module.irsa.aws_lbc_role_arn
  cluster_autoscaler_role_arn = module.irsa.cluster_autoscaler_role_arn
}