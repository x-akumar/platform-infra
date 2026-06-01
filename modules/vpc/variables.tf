variable "vpc_cidr" {
  description = "vpc cidr"
  type        = string
}

variable "public_subnets" {
  type = map(object({ #map store muliplt iteam suing key value pair
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

variable "cluster_name" {
  type = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

