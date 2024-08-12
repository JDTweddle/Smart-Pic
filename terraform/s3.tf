
# creates S3 buckets for website and logging

# create web bucket
resource "aws_s3_bucket" "website_bucket" {
    bucket = var.bucket_name
    
    tags = {
        Name = "s3-static-website"
    }
}

# bucket ownership for web bucket
resource "aws_s3_bucket_ownership_controls" "website_bucket_acl_ownership" {
    bucket = aws_s3_bucket.website_bucket.id

    rule {
        object_ownership = "BucketOwnerPreferred"
    }
}

# public access block to web bucket
resource "aws_s3_bucket_public_access_block" "website_public_access" {
    bucket = aws_s3_bucket.website_bucket.id

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}

# access control list for web buckt
resource "aws_s3_bucket_acl" "website_bucket_acl" {
    depends_on = [
        aws_s3_bucket_ownership_controls.website_bucket_acl_ownership,
        aws_s3_bucket_public_access_block.website_public_access,
    ]

    bucket = aws_s3_bucket.website_bucket.id
    acl    = "public-read"
}

# enabled versioning to web bucket
resource "aws_s3_bucket_versioning" "website_bucket_versioning" {
    bucket = aws_s3_bucket.website_bucket.id
    versioning_configuration {
      status = "Enabled"
    }
}

# bucket policy to only allow access from cloudfront to web bucket
resource "aws_s3_bucket_policy" "website_bucket_policy" {
    bucket = aws_s3_bucket.website_bucket.id

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Sid       = "AllowCloudFrontOAI"
          Effect    = "Allow"
          Principal = {
            AWS = aws_cloudfront_origin_access_identity.oai.iam_arn
          }
          Action   = "s3:GetObject"
          Resource = "${aws_s3_bucket.website_bucket.arn}/*"
        }
      ]
    })
}

# enables encryption at rest for web bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "website_bucket_encryption" {
    bucket = aws_s3_bucket.website_bucket.id
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
}

# web configuration
resource "aws_s3_bucket_website_configuration" "website_config" {
    bucket = aws_s3_bucket.website_bucket.id

    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "error.html"
    }
}

# create bucket for cloudfront logging
resource "aws_s3_bucket" "logs_bucket" {
    bucket = var.bucket_name_2

    tags = {
          Name = "s3-cloudfront-logs"
      }
}

# bucket ownership for logs bucket
resource "aws_s3_bucket_ownership_controls" "logs_bucket_acl_ownership" {
    bucket = aws_s3_bucket.logs_bucket.id

    rule {
        object_ownership = "BucketOwnerPreferred"
    }
}

# enables encryption at rest for logs bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "logs_bucket_encryption" {
    bucket = aws_s3_bucket.logs_bucket.id
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
}

# public access block to the logging bucket
resource "aws_s3_bucket_public_access_block" "logs_public_access_block" {
    bucket = aws_s3_bucket.logs_bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

# access contorl list for logs bucket
resource "aws_s3_bucket_acl" "logs_bucket_acl" {
    depends_on = [aws_s3_bucket_ownership_controls.logs_bucket_acl_ownership]

    bucket = aws_s3_bucket.logs_bucket.id
    acl    = "private"
}

# bucket policy for logs buket
resource "aws_s3_bucket_policy" "logs_bucket_policy" {
    bucket = aws_s3_bucket.logs_bucket.id

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Sid    = "AllowCloudFrontLogDelivery"
          Effect = "Allow"
          Principal = {
            Service = "delivery.logs.amazonaws.com"
          }
          Action   = "s3:PutObject"
          Resource = "${aws_s3_bucket.logs_bucket.arn}/*"
          Condition = {
            StringEquals = {
              "aws:SourceArn" = aws_cloudfront_distribution.cdn.arn
            }
          }
        }
      ]
    })
}
 
# added lifecycle rule to auto delete old logs
resource "aws_s3_bucket_lifecycle_configuration" "logs_bucket_lifecycle" {
    bucket = aws_s3_bucket.logs_bucket.id

    rule {
      id     = "delete_old_logs"
      status = "Enabled"

      expiration {
        days = 90
      }
    }
}