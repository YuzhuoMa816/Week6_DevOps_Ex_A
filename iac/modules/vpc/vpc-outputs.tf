
output "vpc_id" {
  description = "vpc id"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "public subnet ids"
  value       = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  description = "private subnet ids"
  value       = aws_subnet.private_subnet[*].id
}

output "vpc_cidr_block" {
  description = "VPC CIDR block"
  value       = aws_vpc.this.cidr_block
}
