#!/bin/bash
set -e

# Generates a random docker image tag, builds a docker image,
# updates the CloudFormation parameters file with the new image tag,
# and either creates or updates a CloudFormation stack which
# deploys the locally build docker image to the Dev ECS cluster in AWS.
#
# Author: Jason DeBolt (jasondebolt@gmail.com)
#
# USAGE:
#   ./deploy-ecs.sh [create | update] [location of docker file]
#
# EXAMPLES:
#   ./deploy-ecs.sh update .   --> Dockerfile in project root dir.
#   ./deploy-ecs.sh update ecs   --> Dockerfile in ecs dir.

AWS_ACCOUNT_ID=`aws sts get-caller-identity --output text --query Account`
AWS_REGION=`aws configure get region`
PROJECT_NAME=`jq -r '.Parameters.ProjectName' template-jenkins-cluster-params.json`
ENVIRONMENT=`jq -r '.Parameters.Environment' template-jenkins-cluster-params.json`
IMAGE_TAG=$ENVIRONMENT-`date +"%Y-%m-%d-%H%M%S"`
#IMAGE_TAG='latest'
CLOUDFORMATION_BUCKET_NAME='mosaic-phoenix-microservice'

IMAGE_NAME=`jq -r '.Parameters.MasterImageName' template-jenkins-cluster-params.json`
ECR_REPO=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_NAME:$IMAGE_TAG

# Upload template to S3 bucket
aws s3 cp template-jenkins-cluster.json s3://$CLOUDFORMATION_BUCKET_NAME

# Check for valid arguments
if [ $# -ne 2 ]
  then
    echo "Incorrect number of arguments supplied. Pass in either 'create' or 'update' and the location of the docker file"
    exit 1
fi

# This is a regular non-play app, so we use docker build directly.
echo 'docker build'
docker build -t $ECR_REPO $2

# Obtain auth with AWS Elastic Container Rep
eval $(aws ecr get-login --no-include-email --region $AWS_REGION)

# Push the local docker image to AWS Elastic Container Repo
docker push $ECR_REPO

# Replace the IMAGE_TAG string in the devops params file with the $IMAGE_TAG variable
sed "s/IMAGE_TAG/$IMAGE_TAG/g" template-jenkins-cluster-params.json > temp1.json

# Regenerate the devops params file into a format the the CloudFormation CLI expects.
python parameters_generator.py temp1.json > temp2.json

# Validate the CloudFormation template before template execution.
aws cloudformation validate-template --template-url https://s3.amazonaws.com/$CLOUDFORMATION_BUCKET_NAME/template-jenkins-cluster.json

# Create or update the CloudFormation stack with deploys your docker service to the Dev cluster.
aws cloudformation $1-stack --stack-name $PROJECT_NAME-ecs-$ENVIRONMENT \
    --template-url https://s3.amazonaws.com/$CLOUDFORMATION_BUCKET_NAME/'template-jenkins-cluster.json' \
    --parameters file://temp2.json \
    --capabilities CAPABILITY_NAMED_IAM

# Cleanup
rm temp1.json
rm temp2.json
