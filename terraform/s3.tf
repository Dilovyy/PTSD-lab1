resource "aws_s3_bucket" "start" {
  bucket        = var.s3_start_bucket
  force_destroy = true

  lifecycle_rule {
    id      = "expire-old-objects"
    enabled = true

    expiration {
      days = 90
    }
  }
}

resource "aws_s3_bucket" "finish" {
  bucket        = var.s3_finish_bucket
  force_destroy = true

  lifecycle_rule {
    id      = "archive-copied-files"
    enabled = true

    expiration {
      days = 180
    }
  }
}

resource "aws_s3_bucket_notification" "start_trigger" {
  bucket = aws_s3_bucket.start.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_copy.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_s3]
}