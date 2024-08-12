resource "aws_api_gateway_rest_api" "secrets_api" {
  name        = var.api_gateway_name
  description = "API to fetch secrets for static website."
}

resource "aws_api_gateway_resource" "lambda_resource" {
  rest_api_id = aws_api_gateway_rest_api.secrets_api.id
  parent_id   = aws_api_gateway_rest_api.secrets_api.root_resource_id
  path_part   = "secrets"
}

resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = aws_api_gateway_rest_api.secrets_api.id
  resource_id   = aws_api_gateway_resource.lambda_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_lambda_permission" "api_gateway_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.fetch_secrets.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.secrets_api.execution_arn}/*/*"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.secrets_api.id
  resource_id = aws_api_gateway_resource.lambda_resource.id
  http_method = aws_api_gateway_method.get_method.http_method
  type        = "AWS_PROXY"

  integration_http_method = "POST"
  uri                      = aws_lambda_function.fetch_secrets.invoke_arn
}
