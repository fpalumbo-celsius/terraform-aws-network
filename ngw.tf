resource "aws_eip" "nat" {
  tags = {
    Name        = "${var.effort}-${var.environment}-nat"
    Environment = var.environment
    Effort      = var.effort
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[2].id

  tags = {
    Name        = "${var.effort}-${var.environment}"
    Environment = var.environment
    Effort      = var.effort
  }
}