# lambda function to fecth env variables
resource "aws_lambda_function" "fetch_secrets" {
  function_name = var.lambda_function_name
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_function.lambda_handler"

  environment {
    variables = {
      SECRET_NAME = aws_secretsmanager_secret.my_secret.name
    }
  }

  filename         = "path/to/your/lambda_function.zip"  # Ensure you package your Lambda function code
  source_code_hash = filebase64sha256("path/to/your/lambda_function.zip")
}