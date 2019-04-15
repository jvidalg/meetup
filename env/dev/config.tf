terraform{
  backend "s3"{
    bucket = "s3bkt-tfremotestate"
    key = "envs/dev-app/terraform.tfstate"
    dynamodb_table = "terraform-state-lock-dynamo"
    region = "us-east-1"
   
  }
}