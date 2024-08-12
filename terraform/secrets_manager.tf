resource "aws_secretsmanager_secret" "my_secret" {
  name = var.secret_name
}

resource "aws_secretsmanager_secret_version" "my_secret_value" {
  secret_id     = aws_secretsmanager_secret.my_secret.id
  secret_string = jsonencode({
    DB_HOST = "localhost",
    DB_USER = "admin",
    DB_PASS = "secretpassword"
  })
}
