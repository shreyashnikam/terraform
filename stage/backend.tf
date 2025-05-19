terraform {
  backend "s3" {
    bucket         = "stage-iac-state-bucket"
    key            = "env-name/terraform.tfstate"
    region         = "ap-south-1"
    profile        = "stagenew"
    dynamodb_table = "stage-iac-lock-table"
    encrypt        = true
  }
}
