#!/bin/sh

aws s3api create-bucket \
  --bucket $TFSTATE_BUCKET \
  --acl private \
  --create-bucket-configuration LocationConstraint=us-gov-east-1

aws s3api put-bucket-encryption \
  --bucket $TFSTATE_BUCKET \
  --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'
