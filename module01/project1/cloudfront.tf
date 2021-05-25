locals {
  s3_origin_id = "S3-${aws_s3_bucket.staticsite.id}"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.staticsite.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

   # s3_origin_config {
   #   origin_access_identity = "origin-access-identity/cloudfront/ABCDEFG1234567"
   # }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Created by M.M. on 17.05.2021"
  default_root_object = "index.html"
  
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  #  acm_certificate_arn = aws_acm_certificate.cert.acm_certificate_arn
  }
  restrictions {
   geo_restriction {
      restriction_type = "none"
      }
  }

}

##resource "aws_acm_certificate" "cert" {
##  domain_name       = aws_cloudfront_distribution.s3_distribution.domain_name
##  validation_method = "DNS"
##
##  lifecycle {
##    create_before_destroy = true
##  }
##}