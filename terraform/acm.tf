<<<<<<< HEAD
<<<<<<< HEAD
# AWS certificate manager for HTTPS
# remove comments if you want to use a registered domain name
/*resource "aws_acm_certificate" "cert" {
    provider = aws.us-east-1
    domain_name       = var.domain_name
    validation_method = "DNS"

    subject_alternative_names = ["www.${var.domain_name}"]

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_route53_record" "cert_validation" {
    for_each = {
        for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
            name   = dvo.resource_record_name
            record = dvo.resource_record_value
            type   = dvo.resource_record_type
        }
    }

    allow_overwrite = true
    name            = each.value.name
    records         = [each.value.record]
    ttl             = 60
    type            = each.value.type
    zone_id         = aws_route53_zone.primary.zone_id
}

resource "aws_acm_certificate_validation" "cert" {
    provider = aws.us-east-1
    certificate_arn         = aws_acm_certificate.cert.arn
    validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
=======
# AWS certificate manager for HTTPS
# remove comments if you want to use a registered domain name
/*resource "aws_acm_certificate" "cert" {
    provider = aws.us-east-1
    domain_name       = var.domain_name
    validation_method = "DNS"

    subject_alternative_names = ["www.${var.domain_name}"]

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_route53_record" "cert_validation" {
    for_each = {
        for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
            name   = dvo.resource_record_name
            record = dvo.resource_record_value
            type   = dvo.resource_record_type
        }
    }

    allow_overwrite = true
    name            = each.value.name
    records         = [each.value.record]
    ttl             = 60
    type            = each.value.type
    zone_id         = aws_route53_zone.primary.zone_id
}

resource "aws_acm_certificate_validation" "cert" {
    provider = aws.us-east-1
    certificate_arn         = aws_acm_certificate.cert.arn
    validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
>>>>>>> a86843f32a2e09f21ae4a318f261051d2b622d16
=======
<<<<<<< HEAD
# AWS certificate manager for HTTPS
# remove comments if you want to use a registered domain name
/*resource "aws_acm_certificate" "cert" {
    provider = aws.us-east-1
    domain_name       = var.domain_name
    validation_method = "DNS"

    subject_alternative_names = ["www.${var.domain_name}"]

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_route53_record" "cert_validation" {
    for_each = {
        for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
            name   = dvo.resource_record_name
            record = dvo.resource_record_value
            type   = dvo.resource_record_type
        }
    }

    allow_overwrite = true
    name            = each.value.name
    records         = [each.value.record]
    ttl             = 60
    type            = each.value.type
    zone_id         = aws_route53_zone.primary.zone_id
}

resource "aws_acm_certificate_validation" "cert" {
    provider = aws.us-east-1
    certificate_arn         = aws_acm_certificate.cert.arn
    validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
=======
# AWS certificate manager for HTTPS
# remove comments if you want to use a registered domain name
/*resource "aws_acm_certificate" "cert" {
    provider = aws.us-east-1
    domain_name       = var.domain_name
    validation_method = "DNS"

    subject_alternative_names = ["www.${var.domain_name}"]

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_route53_record" "cert_validation" {
    for_each = {
        for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
            name   = dvo.resource_record_name
            record = dvo.resource_record_value
            type   = dvo.resource_record_type
        }
    }

    allow_overwrite = true
    name            = each.value.name
    records         = [each.value.record]
    ttl             = 60
    type            = each.value.type
    zone_id         = aws_route53_zone.primary.zone_id
}

resource "aws_acm_certificate_validation" "cert" {
    provider = aws.us-east-1
    certificate_arn         = aws_acm_certificate.cert.arn
    validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
>>>>>>> a86843f32a2e09f21ae4a318f261051d2b622d16
>>>>>>> 97ee1fc27b5a005f41c5744033d7798273c346db
}*/