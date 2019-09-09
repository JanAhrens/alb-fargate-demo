# alb-fargate-demo

This project is based on [cfn-modules](https://github.com/cfn-modules).

Install dependencies

> npm install

Create an S3 bucket for the CloudFormation templates

> aws s3 mb my-cloudformation-bucket

Deploy the CloudFormation stack

> aws cloudformation package --template-file template.yaml --s3-bucket my-cloudformation-bucket > package.yaml
> aws cloudformation deploy --stack-name 'hello-fargate' --template-file package.yaml --capabilities CAPABILITY_IAM

Create and deploy an updated Docker container

> ./ci.sh