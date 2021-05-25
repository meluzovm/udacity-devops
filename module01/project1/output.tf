output "website_endpoint" {
  value = aws_s3_bucket.staticsite.website_endpoint 
}

output "cloudfront_endpoint" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}