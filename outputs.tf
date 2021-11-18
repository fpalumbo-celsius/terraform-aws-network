output "zone_id" {
    value = aws_route53_zone.private.id
}

output "vpc_id" {
    value = aws_vpc.main.id
}

output "public_subnets" {
    value = aws_subnet.public
}

output "private_subnets" {
    value = aws_subnet.private
}

output "internal_subnets" {
    value = aws_subnet.internal
}

output "management_subnet" {
    value = aws_subnet.management
}

output "bastion_key_name" {
    value = aws_key_pair.bastion.id
}

output "internal_key_name" {
    value = aws_key_pair.internal.id
}

output "bastion_security_group_id" {
    value = aws_security_group.bastion.id
}

output "bastion_id" {
    value = aws_instance.bastion.id
}

output "aws_route_table" {
  value = aws_route_table.public.id
}