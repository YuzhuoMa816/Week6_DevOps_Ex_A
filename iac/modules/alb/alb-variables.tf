variable "project_name" {
  description = "The name of the project."
  type        = string

}
variable "environment" {
  description = "The environment to deploy resources in."
  type        = string
}

variable "public_subnet_ids" {
  description = "The public subnet id"
  type        = list(string)
}


variable "alb_security_group_id" {
  description = "The security group for load balancer"
  type        = string
}


variable "app_port" {
  description = "port of application"
  type        = string

}

variable "vpc_id" {
  description = "VPC id "
  type        = string

}

variable "health_path" {
  description = "path for healthy"
  type        = string

}

