resource "aws_subnet" "internal" {
    count = length(var.internal_subnets)

    vpc_id = aws_vpc.main.id
    cidr_block = var.internal_subnets[count.index].cidr_block
    availability_zone = var.internal_subnets[count.index].availability_zone

    tags = {
        Name        = "${var.effort}-${var.environment}-internal-${count.index + 1}"
        Environment = var.environment
        Effort      = var.effort
    }
}