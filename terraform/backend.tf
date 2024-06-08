# terraform {
#   backend "s3" {}
# }
terraform {
  backend "s3" {
    region = "us-east-1"
    key    = "426857564226/ujwal-ansible-amazon-linux-2.tfstate"
    bucket = "8586-terraform-state"
  }
}