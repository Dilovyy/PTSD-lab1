resource "aws_opensearch_domain" "logs" {
  domain_name    = "file-copy-logs"
  engine_version = "OpenSearch_2.11"

  cluster_config {
    instance_type = "t3.small.search"
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  tags = {
    Name        = "file-copy-logs"
    Environment = "localstack"
  }
}