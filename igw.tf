resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.effort}-${var.environment}"
    Environment = var.environment
    Effort      = var.effort
  }
}