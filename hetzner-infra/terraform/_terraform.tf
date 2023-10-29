terraform {
  required_version = ">= 1.3.9"

  backend "s3" {
    bucket         = "mrf0str-tfstate"
    key            = "hetzner/homelab.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-lock"
    profile        = "mrf0str"
  }

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.44.1"
    }
  }
}
