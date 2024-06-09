terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "8586-terraform-state"
  }
}