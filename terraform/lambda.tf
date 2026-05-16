data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda"
  output_path = "${path.module}/lambda.zip"
}


resource "aws_iam_role" "lambda_exec" {
  name = "lambda-s3-copy-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda-policy"
  role = aws_iam_role.lambda_exec.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = "${aws_s3_bucket.start.arn}/*"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:PutObject"]
        Resource = "${aws_s3_bucket.finish.arn}/*"
      },
      {
        Effect   = "Allow"
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect   = "Allow"
        Action   = ["es:ESHttpPost", "es:ESHttpPut", "es:ESHttpGet"]
        Resource = "${aws_opensearch_domain.logs.arn}/*"
      }
    ]
  })
}



resource "aws_lambda_function" "s3_copy" {
  function_name    = var.lambda_function_name
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda.handler"
  runtime          = "python3.11"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  timeout          = 30

  environment {
    variables = {
      DEST_BUCKET         = var.s3_finish_bucket
      LOCALSTACK_ENDPOINT = "http://localhost.localstack.cloud:4566"
      OPENSEARCH_ENDPOINT = "http://file-copy-logs.us-east-1.opensearch.localhost.localstack.cloud:4566"
    }
  }

  depends_on = [
    aws_iam_role_policy.lambda_policy,
    aws_opensearch_domain.logs,
  ]
}


resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_copy.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.start.arn
}