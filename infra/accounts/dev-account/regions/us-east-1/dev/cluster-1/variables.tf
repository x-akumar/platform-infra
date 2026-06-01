variable "vpc_cidr" {
  description = "vpc cidr"
  type        = string
}


variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "cluster_name" {
  description = "eks cluster name"
  type        = string
}

variable "kubernetes_version" {
  type = string
}

variable "instance_types" {

  type = list(string)

}

variable "desired_size" {

  type = number

}

variable "min_size" {

  type = number

}

variable "max_size" {

  type = number

}


variable "coredns_version" {
  type = string
}

variable "kube_proxy_version" {
  type = string
}

variable "vpc_cni_version" {
  type = string
}


variable "aws_region" {
  type = string
}
