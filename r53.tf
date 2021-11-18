resource "aws_route53_zone" "private" {
  name   = "${var.environment}.${var.effort}"

  vpc {
    vpc_id = aws_vpc.main.id
    vpc_region = var.region
  }

  tags = {
    Name        = "${var.effort}-${var.environment}-private"
    Environment = var.environment
    Effort      = var.effort
  }
}
