# Defines the AWS region where our resources will be created.
variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

# Defines the name for our project, used for tagging.
variable "project_name" {
  description = "The name of the project, used for tagging resources."
  type        = string
  default     = "automated-deployment"
}

# Defines the name for the EC2 key pair.
variable "key_name" {
  description = "The name of the EC2 key pair."
  type        = string
  default     = "automated-deployment-tf"
}