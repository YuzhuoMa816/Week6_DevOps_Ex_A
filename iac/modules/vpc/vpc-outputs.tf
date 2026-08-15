
# Output the ID of the created VPC.
# This is useful when other modules or resources need to reference the VPC.
output "vpc_id" {
  description = "vpc id"
  value       = aws_vpc.this.id
}

# Output the IDs of all public subnets.
# These values can be reused by other modules such as load balancers or EC2 instances.
output "public_subnet_ids" {
  description = "public subnet ids"
  value       = aws_subnet.public_subnet[*].id
}

# Output the IDs of all private subnets.
# These values are useful when attaching private services such as RDS or application servers.
output "private_subnet_ids" {
  description = "private subnet ids"
  value       = aws_subnet.private_subnet[*].id
}

# Output the CIDR block of the VPC.
# This helps confirm the network range configured for the environment.
output "vpc_cidr_block" {
  description = "VPC CIDR block"
  value       = aws_vpc.this.cidr_block
}
