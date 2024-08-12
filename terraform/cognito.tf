
resource "aws_cognito_user_pool" "main" {
  name = "smartpic-user-pool"

  username_attributes = ["email"]
  auto_verified_attributes = ["email"]

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject = "Account Confirmation"
    email_message = "Your confirmation code is {####}"
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name = "smartpic-client"

  user_pool_id = aws_cognito_user_pool.main.id

  generate_secret     = false
  explicit_auth_flows = ["ALLOW_USER_SRP_AUTH","ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["phone", "email", "openid", "profile", "aws.cognito.signin.user.admin"]
  callback_urls                        = ["http://localhost:3000/", var.domain_name]
  logout_urls                          = ["http://localhost:3000/", var.domain_name]
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "smartpic"
  user_pool_id = aws_cognito_user_pool.main.id
}