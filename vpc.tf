resource "aws_vpc" "main" {
    cidr_block = var.cidr_block

    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name        = "${var.effort}-${var.environment}"
        Environment = var.environment
        Effort      = var.effort
    }
}