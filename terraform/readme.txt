Для перевірки
docker exec -it localstack sh -c "echo 'ddddddd' > /tmp/texttobecopied.txt"
docker exec -it localstack awslocal s3 cp /tmp/texttobecopied.txt s3://s3-start/text.txt
docker exec -it localstack awslocal s3 ls s3://s3-finish/
