resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.main.id

  tags = merge(

    var.tags,

    {

      Name = "${var.tags["Project"]}-${var.tags["Environment"]}-igw"

    }

  )
}

resource "aws_eip" "nat" {
  domain = "vpc"
}


resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id

  subnet_id = aws_subnet.public["public-a"].id

  tags = merge(

    var.tags,

    {

      Name = "${var.tags["Project"]}-${var.tags["Environment"]}-nat-gateway"

    }

  )

  depends_on = [aws_internet_gateway.this]
}
