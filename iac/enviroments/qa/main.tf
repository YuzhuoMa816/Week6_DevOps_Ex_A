provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr             = var.vpc_cidr
  project_name         = var.project_name
  environment          = var.environment
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "security" {
  source = "../../modules/security"


  vpc_id       = module.vpc.vpc_id
  db_port      = var.db_port
  environment  = var.environment
  project_name = var.project_name
  app_port     = var.app_port
}


module "rds" {
  source = "../../modules/rds"


  private_subnet_ids    = module.vpc.private_subnet_ids
  db_port               = var.db_port
  environment           = var.environment
  project_name          = var.project_name
  allocated_storage     = var.allocated_storage
  storage_type          = var.storage_type
  db_instance_class     = var.db_instance_class
  db_name               = var.db_name
  db_username           = var.db_username
  rds_security_group_id = module.security.rds_sg_id
  db_engine             = var.db_engine
  db_engine_version     = var.db_engine_version
}


module "alb" {
  source = "../../modules/alb"

  environment           = var.environment
  project_name          = var.project_name
  public_subnet_ids     = module.vpc.public_subnet_ids
  alb_security_group_id = module.security.alb_sg_id
  app_port              = var.app_port
  vpc_id                = module.vpc.vpc_id
  health_path           = var.health_path



}



module "ecs" {
  source = "../../modules/ecs"

  depends_on = [module.alb]


  environment           = var.environment
  project_name          = var.project_name
  aws_region            = var.aws_region
  private_subnet_ids    = module.vpc.private_subnet_ids
  ecs_security_group_id = module.security.ecs_sg_id
  target_group_arn      = module.alb.target_group_arn
  image_uri             = "${var.ecr_repository_url}:${var.image_tag}"
  desired_count         = var.desired_count
  task_cpu              = var.task_cpu
  task_memory           = var.task_memory
  app_port              = var.app_port
  container_name        = var.container_name


  db_host                = module.rds.db_host
  db_name                = var.db_name
  db_port                = var.db_port
  db_username            = var.db_username
  db_password_secret_arn = module.rds.db_password_secret_arn
  build_tag              = var.image_tag
}
