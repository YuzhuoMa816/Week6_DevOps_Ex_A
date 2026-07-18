
variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "ap-southeast-2"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "project_name" {
  description = "The name of the project."
  type        = string
  default     = "my-project"
}

variable "environment" {
  description = "The environment to deploy resources in."
  type        = string
  default     = "dev"
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets."
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "db_port" {
  description = "The port for the RDS instance."
  type        = number
  default     = 5432
}

variable "app_port" {
  description = "The port for the application."
  type        = number
  default     = 8080
}

variable "allocated_storage" {
  description = "The amount of storage to allocate for the RDS instance."
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "The type of storage to use for the RDS instance."
  type        = string
  default     = "gp2"
}

variable "db_instance_class" {
  description = "The instance class for the RDS instance."
  type        = string
  default     = "db.t3.micro"
}

variable "db_username" {
  description = "The username for the database."
  type        = string
  default     = "myuser"
}

variable "db_name" {
  description = "The name of the database."
  type        = string
  default     = "mydatabase"
}


variable "db_engine" {
  description = "The database engine for the RDS instance."
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "The version of the database engine."
  type        = string
  default     = "16.9"
}

variable "health_path" {
  description = "The health path check for Target group."
  type        = string
  default     = "/health"
}

variable "desired_count" {
  description = "The desired count for ECS service instance."
  type        = string
  default     = "1"
}


variable "task_cpu" {
  description = "The CPU unit allocate for ECS service instance."
  type        = string
  default     = "512"

}

variable "task_memory" {
  description = "The Memory (MB) allocate for ECS service instance."
  type        = string
  default     = "1024"

}

variable "container_name" {
  description = "The container name for ECS service instance."
  type        = string
  default     = "my-project-container"

}

variable "image_tag" {
  description = "The image tag."
  type        = string
  default     = "latest"

}
