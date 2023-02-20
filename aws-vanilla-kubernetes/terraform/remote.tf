terraform {
  backend "s3" {
    bucket         = "mrf0str-tfstate"
    key            = "main.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-lock"
  }
}
