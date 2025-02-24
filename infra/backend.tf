# Purpose: This file is used to configure the backend for the terraform state file.

# state locking configuration
terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "s3-cloud-native-terraform"
    key    = "v1/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}

