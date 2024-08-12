
# stores variables separatley so easy to find and change names

variable "aws_region" {
  description = "The AWS region to create resources in."
  default     = "region you are using"
}

variable "domain_name" {
  description = "The domain name for the website"
  type        = string
  default     = "domain name"
}

# Name for static web bucket
variable "bucket_name" {
  description = "name of bucket for static website"
  type        = string
  default     = "bucket name"
}

# Name for logs bucket
variable "bucket_name_2" {
  description = "name of bucket for storing logs"
  type        = string
  default     = "bucket name"
}

variable "secret_name" {
  description = "The name of the secret in Secrets Manager."
}

variable "lambda_function_name" {
  description = "The name of the Lambda function."
  default     = "fetch-secrets-function"
}

variable "api_gateway_name" {
  description = "The name of the API Gateway."
  default     = "secrets-api"
}