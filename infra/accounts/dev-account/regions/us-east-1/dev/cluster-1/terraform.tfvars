vpc_cidr = "10.0.0.0/16"

public_subnets = {
  public-a = {
    cidr = "10.0.1.0/24"
    az   = "us-east-1a"
  }

  public-b = {
    cidr = "10.0.2.0/24"
    az   = "us-east-1b"
  }

  public-c = {
    cidr = "10.0.3.0/24"
    az   = "us-east-1c"
  }
}

private_subnets = {
  private-a = {
    cidr = "10.0.11.0/24"
    az   = "us-east-1a"
  }

  private-b = {
    cidr = "10.0.12.0/24"
    az   = "us-east-1b"
  }

  private-c = {
    cidr = "10.0.13.0/24"
    az   = "us-east-1c"
  }
}


tags = {
  Project     = "test"
  Environment = "dev"
  ManagedBy   = "terraform"
}

cluster_name = "eks-dev-cluster"

kubernetes_version = "1.33"

instance_types = ["t3.medium"]

desired_size = 2
min_size     = 2
max_size     = 3

coredns_version    = "v1.13.2-eksbuild.7"
kube_proxy_version = "v1.33.10-eksbuild.5"
vpc_cni_version    = "v1.21.1-eksbuild.8"


aws_region = "us-east-1"