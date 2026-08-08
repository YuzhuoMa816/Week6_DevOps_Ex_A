terraform {
  backend "s3" {
    bucket         = "week6-devops-ex-a-patrick-tf-state"
    key            = "iac/environments/prod/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "week6-devops-ex-a-tf-locks"
    encrypt        = true
  }
}
