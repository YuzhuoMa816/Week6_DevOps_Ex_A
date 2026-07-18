
variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The environment to deploy resources in."
  type        = string
}


variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
}

variable "db_name" {
  description = "The name of the database."
  type        = string
}

variable "db_username" {
  description = "The username for the database."
  type        = string
}

variable "db_port" {
  description = "The port for the RDS instance."
  type        = number
}

variable "allocated_storage" {
  description = "The allocated storage for the RDS instance in GB."
  type        = number
}

variable "storage_type" {
  description = "The storage type for the RDS instance."
  type        = string
}

variable "private_subnet_ids" {
  description = "The IDs of the private subnets."
  type        = list(string)
}

variable "rds_security_group_id" {
  description = "The ID of the security group for the RDS instance."
  type        = string
}

variable "db_engine" {
  description = "The database engine for the RDS instance."
  type        = string
}

variable "db_engine_version" {
  description = "The version of the database engine."
  type        = string
}
