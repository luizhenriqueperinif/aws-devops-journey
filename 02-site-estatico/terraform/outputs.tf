output "site_url" {
  description = "Endereco do site"
  value       = "https://${aws_cloudfront_distribution.site.domain_name}"
}

output "distribution_id" {
  description = "ID para criar invalidacoes"
  value       = aws_cloudfront_distribution.site.id
}

output "bucket_name" {
  description = "Bucket para o aws s3 sync"
  value       = aws_s3_bucket.site.id
}