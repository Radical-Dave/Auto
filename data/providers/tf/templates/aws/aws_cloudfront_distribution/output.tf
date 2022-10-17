output "id" {
  description = "The id of the aws_cloudfront_distribution"
  value       = aws_cloudfront_distribution.this.id
}
output "this" {
  description = "The aws_cloudfront_distribution"
  value       = aws_cloudfront_distribution.this
}