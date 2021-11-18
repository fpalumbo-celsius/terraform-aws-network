resource "aws_subnet" "public" {
    count = length(var.public_subnets)

    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnets[count.index].cidr_block
    availability_zone = var.public_subnets[count.index].availability_zone

    tags = {
        Name        = "${var.effort}-${var.environment}-public-${count.index + 1}"
        Environment = var.environment
        Effort      = var.effort
    }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.effort}-${var.environment}-public"
    Environment = var.environment
    Effort      = var.effort
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}