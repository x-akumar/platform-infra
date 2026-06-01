resource "aws_subnet" "public" {
  for_each = var.public_subnets #Terraform loops through every entry.

  vpc_id                  = aws_vpc.main.id #Attach subnet to the VPC.
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name                                        = "${var.tags["Project"]}-${var.tags["Environment"]}-${each.key}"
      "kubernetes.io/role/elb"                    = "1"
      "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
  )
}


resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = false

  tags = merge(

    var.tags,

    {

      Name = "${var.tags["Project"]}-${var.tags["Environment"]}-${each.key}"

      "kubernetes.io/role/internal-elb"           = "1"
      "kubernetes.io/cluster/${var.cluster_name}" = "shared"

    }

  )
}
