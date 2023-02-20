terraform {
  backend "s3" {
    bucket         = "mrf0str-tfstate"
    key            = "eks.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-lock"
  }
}
