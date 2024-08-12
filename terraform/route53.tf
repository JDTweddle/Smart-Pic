
# leverage route 53 for DNS
# remove comments if you want to use a registered domain name
/*resource "aws_route53_zone" "primary" {
    name = var.domain_name
}

resource "aws_route53_record" "www" {
    zone_id = aws_route53_zone.primary.zone_id
    name    = "www.${var.domain_name}"
    type    = "A"

    alias {
        name                   = aws_cloudfront_distribution.cdn.domain_name
        zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
        evaluate_target_health = false
    }
}

resource "aws_route53_record" "apex" {
    zone_id = aws_route53_zone.primary.zone_id
    name    = var.domain_name
    type    = "A"

    alias {
        name                   = aws_cloudfront_distribution.cdn.domain_name
        zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
        evaluate_target_health = false
    }
=======
# leverage route 53 for DNS
# remove comments if you want to use a registered domain name
/*resource "aws_route53_zone" "primary" {
    name = var.domain_name
}

resource "aws_route53_record" "www" {
    zone_id = aws_route53_zone.primary.zone_id
    name    = "www.${var.domain_name}"
    type    = "A"

    alias {
        name                   = aws_cloudfront_distribution.cdn.domain_name
        zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
        evaluate_target_health = false
    }
}

resource "aws_route53_record" "apex" {
    zone_id = aws_route53_zone.primary.zone_id
    name    = var.domain_name
    type    = "A"

    alias {
        name                   = aws_cloudfront_distribution.cdn.domain_name
        zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
        evaluate_target_health = false
    }
}*/