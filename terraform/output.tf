
# outputs

output "website_endpoint" {
    value       = aws_cloudfront_distribution.cdn.domain_name
    description = "The CloudFront distribution domain name"
}

# remove comments if you want to use a registered domain name
/*output "certificate_arn" {
    value       = aws_acm_certificate.cert.arn
    description = "The ARN of the SSL/TLS certificate"
}*/

output "user_pool_id" {
  value = aws_cognito_user_pool.main.id
}

output "app_client_id" {
  value = aws_cognito_user_pool_client.client.id
}

output "cognito_domain" {
  value = "https://${aws_cognito_user_pool_domain.main.domain}.auth.${var.aws_region}.amazoncognito.com"
}

output "api_url" {
  value = "${aws_api_gateway_rest_api.secrets_api.execution_arn}/secrets"
}
