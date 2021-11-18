resource "aws_subnet" "private" {
    count = length(var.private_subnets)

    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnets[count.index].cidr_block
    availability_zone = var.private_subnets[count.index].availability_zone

    tags = {
        Name        = "${var.effort}-${var.environment}-private-${count.index + 1}"
        Environment = var.environment
        Effort      = var.effort
    }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name        = "${var.effort}-${var.environment}-private"
    Environment = var.environment
    Effort      = var.effort
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.public_subnets)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
