<<<<<<< HEAD
<<<<<<< HEAD
# create cloudfront CDN wit access to S3 bucket

# OAI access for S3
resource "aws_cloudfront_origin_access_identity" "oai" {
    comment = "OAI for Cloudfront to access S3"
}

# enable cloudfront
resource "aws_cloudfront_distribution" "cdn" {
    origin {
        domain_name = aws_s3_bucket.website_bucket.bucket_regional_domain_name
        origin_id   = "S3-${aws_s3_bucket.website_bucket.bucket}"

        s3_origin_config {
            origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
        }
    }

    enabled             = true
    is_ipv6_enabled     = true
    default_root_object = "index.html"
    comment             = "Static website distribution"

    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD", "OPTIONS"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "S3-${aws_s3_bucket.website_bucket.bucket}"
        response_headers_policy_id = aws_cloudfront_response_headers_policy.security_headers_policy.id


        forwarded_values {
            query_string = false
            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "redirect-to-https"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    viewer_certificate {
        cloudfront_default_certificate = true
    }

    logging_config {
        include_cookies = false
        bucket          = aws_s3_bucket.logs_bucket.bucket_domain_name
        prefix          = "cloudfront-logs/"
  }
    
    tags = {
        Name = "cloudfront-distribution"
    }

    depends_on = [aws_cloudfront_origin_access_identity.oai]
}

    # replace with default certificate if you want to use a registered domain name
    /*viewer_certificate {
        acm_certificate_arn = aws_acm_certificate.cert.arn
        ssl_support_method  = "sni-only"
    }*/

    # remove comments to enable waf with waf.tf file
    /*web_acl_id = aws_wafv2_web_acl.cloudfront_waf.arn


    tags = {
        Name = "cloudfront-distribution"
    }

    depends_on = [aws_acm_certificate_validation.cert*/

# cloudfront security headers
resource "aws_cloudfront_response_headers_policy" "security_headers_policy" {
  name    = "SecurityHeadersPolicy"
  comment = "Security headers policy"
  
  security_headers_config {
    content_type_options {
      override = true
    }
    frame_options {
      frame_option = "DENY"
      override = true
    }
    referrer_policy {
      referrer_policy = "strict-origin-when-cross-origin"
      override = true
    }
    xss_protection {
      mode_block = true
      protection = true
      override = true
    }
    strict_transport_security {
      access_control_max_age_sec = 31536000
      include_subdomains = true
      preload = true
      override = true
    }
  }
=======
# create cloudfront CDN wit access to S3 bucket

# OAI access for S3
resource "aws_cloudfront_origin_access_identity" "oai" {
    comment = "OAI for Cloudfront to access S3"
}

# enable cloudfront
resource "aws_cloudfront_distribution" "cdn" {
    origin {
        domain_name = aws_s3_bucket.website_bucket.bucket_regional_domain_name
        origin_id   = "S3-${aws_s3_bucket.website_bucket.bucket}"

        s3_origin_config {
            origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
        }
    }

    enabled             = true
    is_ipv6_enabled     = true
    default_root_object = "index.html"
    comment             = "Static website distribution"

    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD", "OPTIONS"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "S3-${aws_s3_bucket.website_bucket.bucket}"
        response_headers_policy_id = aws_cloudfront_response_headers_policy.security_headers_policy.id


        forwarded_values {
            query_string = false
            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "redirect-to-https"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    viewer_certificate {
        cloudfront_default_certificate = true
    }

    logging_config {
        include_cookies = false
        bucket          = aws_s3_bucket.logs_bucket.bucket_domain_name
        prefix          = "cloudfront-logs/"
  }
    
    tags = {
        Name = "cloudfront-distribution"
    }

    depends_on = [aws_cloudfront_origin_access_identity.oai]
}

    # replace with default certificate if you want to use a registered domain name
    /*viewer_certificate {
        acm_certificate_arn = aws_acm_certificate.cert.arn
        ssl_support_method  = "sni-only"
    }*/

    # remove comments to enable waf with waf.tf file
    /*web_acl_id = aws_wafv2_web_acl.cloudfront_waf.arn


    tags = {
        Name = "cloudfront-distribution"
    }

    depends_on = [aws_acm_certificate_validation.cert*/

# cloudfront security headers
resource "aws_cloudfront_response_headers_policy" "security_headers_policy" {
  name    = "SecurityHeadersPolicy"
  comment = "Security headers policy"
  
  security_headers_config {
    content_type_options {
      override = true
    }
    frame_options {
      frame_option = "DENY"
      override = true
    }
    referrer_policy {
      referrer_policy = "strict-origin-when-cross-origin"
      override = true
    }
    xss_protection {
      mode_block = true
      protection = true
      override = true
    }
    strict_transport_security {
      access_control_max_age_sec = 31536000
      include_subdomains = true
      preload = true
      override = true
    }
  }
>>>>>>> a86843f32a2e09f21ae4a318f261051d2b622d16
=======
<<<<<<< HEAD
# create cloudfront CDN wit access to S3 bucket

# OAI access for S3
resource "aws_cloudfront_origin_access_identity" "oai" {
    comment = "OAI for Cloudfront to access S3"
}

# enable cloudfront
resource "aws_cloudfront_distribution" "cdn" {
    origin {
        domain_name = aws_s3_bucket.website_bucket.bucket_regional_domain_name
        origin_id   = "S3-${aws_s3_bucket.website_bucket.bucket}"

        s3_origin_config {
            origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
        }
    }

    enabled             = true
    is_ipv6_enabled     = true
    default_root_object = "index.html"
    comment             = "Static website distribution"

    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD", "OPTIONS"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "S3-${aws_s3_bucket.website_bucket.bucket}"
        response_headers_policy_id = aws_cloudfront_response_headers_policy.security_headers_policy.id


        forwarded_values {
            query_string = false
            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "redirect-to-https"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    viewer_certificate {
        cloudfront_default_certificate = true
    }

    logging_config {
        include_cookies = false
        bucket          = aws_s3_bucket.logs_bucket.bucket_domain_name
        prefix          = "cloudfront-logs/"
  }
    
    tags = {
        Name = "cloudfront-distribution"
    }

    depends_on = [aws_cloudfront_origin_access_identity.oai]
}

    # replace with default certificate if you want to use a registered domain name
    /*viewer_certificate {
        acm_certificate_arn = aws_acm_certificate.cert.arn
        ssl_support_method  = "sni-only"
    }*/

    # remove comments to enable waf with waf.tf file
    /*web_acl_id = aws_wafv2_web_acl.cloudfront_waf.arn


    tags = {
        Name = "cloudfront-distribution"
    }

    depends_on = [aws_acm_certificate_validation.cert*/

# cloudfront security headers
resource "aws_cloudfront_response_headers_policy" "security_headers_policy" {
  name    = "SecurityHeadersPolicy"
  comment = "Security headers policy"
  
  security_headers_config {
    content_type_options {
      override = true
    }
    frame_options {
      frame_option = "DENY"
      override = true
    }
    referrer_policy {
      referrer_policy = "strict-origin-when-cross-origin"
      override = true
    }
    xss_protection {
      mode_block = true
      protection = true
      override = true
    }
    strict_transport_security {
      access_control_max_age_sec = 31536000
      include_subdomains = true
      preload = true
      override = true
    }
  }
=======
# create cloudfront CDN wit access to S3 bucket

# OAI access for S3
resource "aws_cloudfront_origin_access_identity" "oai" {
    comment = "OAI for Cloudfront to access S3"
}

# enable cloudfront
resource "aws_cloudfront_distribution" "cdn" {
    origin {
        domain_name = aws_s3_bucket.website_bucket.bucket_regional_domain_name
        origin_id   = "S3-${aws_s3_bucket.website_bucket.bucket}"

        s3_origin_config {
            origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
        }
    }

    enabled             = true
    is_ipv6_enabled     = true
    default_root_object = "index.html"
    comment             = "Static website distribution"

    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD", "OPTIONS"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "S3-${aws_s3_bucket.website_bucket.bucket}"
        response_headers_policy_id = aws_cloudfront_response_headers_policy.security_headers_policy.id


        forwarded_values {
            query_string = false
            cookies {
                forward = "none"
            }
        }

        viewer_protocol_policy = "redirect-to-https"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
    }

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    viewer_certificate {
        cloudfront_default_certificate = true
    }

    logging_config {
        include_cookies = false
        bucket          = aws_s3_bucket.logs_bucket.bucket_domain_name
        prefix          = "cloudfront-logs/"
  }
    
    tags = {
        Name = "cloudfront-distribution"
    }

    depends_on = [aws_cloudfront_origin_access_identity.oai]
}

    # replace with default certificate if you want to use a registered domain name
    /*viewer_certificate {
        acm_certificate_arn = aws_acm_certificate.cert.arn
        ssl_support_method  = "sni-only"
    }*/

    # remove comments to enable waf with waf.tf file
    /*web_acl_id = aws_wafv2_web_acl.cloudfront_waf.arn


    tags = {
        Name = "cloudfront-distribution"
    }

    depends_on = [aws_acm_certificate_validation.cert*/

# cloudfront security headers
resource "aws_cloudfront_response_headers_policy" "security_headers_policy" {
  name    = "SecurityHeadersPolicy"
  comment = "Security headers policy"
  
  security_headers_config {
    content_type_options {
      override = true
    }
    frame_options {
      frame_option = "DENY"
      override = true
    }
    referrer_policy {
      referrer_policy = "strict-origin-when-cross-origin"
      override = true
    }
    xss_protection {
      mode_block = true
      protection = true
      override = true
    }
    strict_transport_security {
      access_control_max_age_sec = 31536000
      include_subdomains = true
      preload = true
      override = true
    }
  }
>>>>>>> a86843f32a2e09f21ae4a318f261051d2b622d16
>>>>>>> 97ee1fc27b5a005f41c5744033d7798273c346db
}