output "arn" {
  description = "The arn of the aws_s3_bucket"
  value       = aws_s3_bucket.this.arn
}
output "bucket_prefix" {
  description = "The bueckt_prefix of the aws_s3_bucket"
  value       = aws_s3_bucket.this.bucket_prefix
}
output "bucket_domain_name" {
  description = "The bucket_domain_name of the aws_s3_bucket"
  value       = aws_s3_bucket.this.bucket_domain_name
}
output "bucket_regional_domain_name" {
  description = "The bucket_regional_domain_name of the aws_s3_bucket"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}
output "hosted_zone_id" {
  description = "The hosted_zone_id of the aws_s3_bucket"
  value       = aws_s3_bucket.this.hosted_zone_id
}
output "id" {
  description = "The ID of the aws_s3_bucket"
  value       = aws_s3_bucket.this.id
}
output "region" {
  description = "The region of the aws_s3_bucket"
  value       = aws_s3_bucket.this.region
}
output "tags" {
  description = "The ID of the aws_s3_bucket"
  value       = aws_s3_bucket.this.tags
}
output "website_domain" {
  description = "The website_domain of the aws_s3_bucket"
  value       = aws_s3_bucket.this.website_domain
}
output "website_endpoint" {
  description = "The website_endpoint of the aws_s3_bucket"
  value       = aws_s3_bucket.this.website_endpoint
}