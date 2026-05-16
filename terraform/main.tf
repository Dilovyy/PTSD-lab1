provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style = true

#Because of using tflocal - endpoints for all services are configured to point to the LocalStack API (http://localhost:4566 by default)
  #endpoints {
   # s3             = "http://localhost:4566"
    #lambda         = "http://localhost:4566"
    #iam            = "http://localhost:4566"
    #opensearch     = "http://localhost:4566"
  #}
}


output "s3_start"  { value = aws_s3_bucket.start.id }
output "s3_finish" { value = aws_s3_bucket.finish.id }
output "lambda"    { value = aws_lambda_function.s3_copy.function_name }
output "opensearch_endpoint" {value = aws_opensearch_domain.logs.endpoint}