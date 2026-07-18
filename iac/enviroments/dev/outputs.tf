output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "alb_sg_id" {
  value = module.security.alb_sg_id
}

output "ecs_sg_id" {
  value = module.security.ecs_sg_id
}

output "rds_sg_id" {
  value = module.security.rds_sg_id
}

output "rds_address" {
  value = module.rds.db_host
}

output "db_password_secret_arn" {
  value = module.rds.db_password_secret_arn
}

output "repository_url" {
  value = module.ecr.repository_url
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "ecs_service_name" {
  value = module.ecs.service_name
}


output "alb_dns" {
  value = module.alb.alb_dns_name
}
