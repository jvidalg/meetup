data "terraform_remote_state" "vpc_state"
{
  backend = "s3"
  config{
    bucket = "s3bkt-tfremotestate"
    key = "envs/dev/terraform.tfstate"
    region = "us-east-1"
  }
} 
