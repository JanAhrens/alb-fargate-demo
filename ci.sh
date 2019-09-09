#!/bin/bash
# Create and deploy an updated Docker container
# This script could also be replaced by AWS CodeBuild
set -e

build_number=$(date +%s)
repo=$(aws cloudformation describe-stacks --stack-name 'hello-fargate' | jq -r '.Stacks[0].Outputs[] | select(.OutputKey == "Repository").OutputValue')
s3_bucket=cf-templates-gigzh34f6ajh-eu-west-1

docker build -t hello:$build_number .
docker tag hello:$build_number $repo:$build_number
docker push $repo:$build_number

aws cloudformation package --template-file template.yaml --s3-bucket "$s3_bucket" > package.yaml
aws cloudformation deploy --stack-name 'hello-fargate' --template-file package.yaml \
    --capabilities CAPABILITY_IAM \
    --parameter-overrides AppImage=$repo:$build_number