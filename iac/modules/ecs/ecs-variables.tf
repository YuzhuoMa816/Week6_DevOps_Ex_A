variable "project_name" {
  type = string

}

variable "environment" {
  type = string

}

variable "db_password_secret_arn" {
  type = string

}


variable "aws_region" {
  type = string

}

variable "db_name" {
  type = string

}


variable "db_username" {
  type = string

}


variable "db_port" {
  type = number

}


variable "db_host" {
  type = string

}

variable "build_tag" {
  type = string
}

variable "app_port" {
  type = number

}


variable "container_name" {
  type = string

}

variable "image_uri" {
  type = string

}

variable "task_cpu" {
  type = string

}

variable "task_memory" {
  type = string

}

variable "desired_count" {
  type = string

}
variable "private_subnet_ids" {
  type = list(string)
}

variable "ecs_security_group_id" {
  type = string
}

variable "target_group_arn" {
  type = string

}
