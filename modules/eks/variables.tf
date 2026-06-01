variable "cluster_name" {
  type = string
}

variable "cluster_role_arn" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "kubernetes_version" {
  type = string
}
variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "node_group_role_arn" {
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