variable "s3_start_bucket" {
  default = "s3-start"
}

variable "s3_finish_bucket" {
  default = "s3-finish"
}

variable "lambda_function_name" {
  default = "s3-copy-lambda"
}


variable "log_retention_days" {
  default = 7
}