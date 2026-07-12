variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The environment to deploy resources in."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "db_port" {
  description = "The port for the RDS instance."
  type        = number
}

variable "app_port" {
  description = "The port for the application."
  type        = number
}
