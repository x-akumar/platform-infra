output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "aws_lbc_role_arn" {
  value = module.irsa.aws_lbc_role_arn
}

output "cluster_autoscaler_role_arn" {
  value = module.irsa.cluster_autoscaler_role_arn
}