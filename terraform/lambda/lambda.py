import json, logging, os, boto3, urllib.request, urllib.error
from urllib.parse import unquote_plus
from datetime import datetime, timezone

logger = logging.getLogger()
logger.setLevel(logging.INFO)

DEST_BUCKET        = os.environ["DEST_BUCKET"]
ENDPOINT           = os.environ.get("LOCALSTACK_ENDPOINT", "http://localhost.localstack.cloud:4566")
OPENSEARCH_ENDPOINT = os.environ["OPENSEARCH_ENDPOINT"]

s3 = boto3.client("s3", endpoint_url=ENDPOINT)


def send_to_opensearch(doc: dict):
    url = f"{OPENSEARCH_ENDPOINT}/file-copy-logs/_doc"
    body = json.dumps(doc).encode()
    req = urllib.request.Request(
        url,
        data=body,
        headers={"Content-Type": "application/json"},
        method="POST",
    )
    try:
        with urllib.request.urlopen(req, timeout=5) as resp:
            logger.info("OpenSearch response: %s", resp.read().decode())
    except urllib.error.URLError as e:
        logger.error("OpenSearch write failed: %s", e)


def handler(event, context):
    logger.info("Event: %s", json.dumps(event))

    for record in event.get("Records", []):
        src_bucket = record["s3"]["bucket"]["name"]
        src_key    = unquote_plus(record["s3"]["object"]["key"])
        file_size  = record["s3"]["object"].get("size", 0)

        s3.copy_object(
            CopySource={"Bucket": src_bucket, "Key": src_key},
            Bucket=DEST_BUCKET,
            Key=src_key,
        )
        logger.info("Copied %s → %s", src_key, DEST_BUCKET)

        send_to_opensearch({
            "timestamp":   datetime.now(timezone.utc).isoformat(),
            "event":       "FILE_COPIED",
            "source":      f"s3://{src_bucket}/{src_key}",
            "destination": f"s3://{DEST_BUCKET}/{src_key}",
            "size_bytes":  file_size,
        })

    return {"statusCode": 200}