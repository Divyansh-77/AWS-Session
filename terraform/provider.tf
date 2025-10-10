# This block configures the Amazon Web Services (AWS) provider.
# It tells Terraform we are building our infrastructure on AWS.
provider "aws" {
  # We set our desired region using the variable "aws_region".
  # This keeps our code clean and easy to update.
  region = var.aws_region
}

# This block tells Terraform what version of the AWS provider we want.
# It's good practice to lock the version to prevent unexpected changes.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}