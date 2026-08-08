# This variable defines the IP address range for the whole VPC.
# Example: "10.0.0.0/16"
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

# This variable stores the project name used in resource tags.
# It helps make resources easier to identify in AWS.
variable "project_name" {
  description = "The name of the project."
  type        = string
}

# This variable identifies the deployment environment, such as dev or staging.
# It is used in naming and tagging resources.
variable "environment" {
  description = "The environment to deploy resources in."
  type        = string
}

# This variable contains the CIDR blocks for all public subnets.
# Public subnets are usually used by internet-facing resources.
variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets."
  type        = list(string)
}

# This variable contains the CIDR blocks for all private subnets.
# Private subnets are usually used by backend services that should not be directly exposed.
variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets."
  type        = list(string)
}
