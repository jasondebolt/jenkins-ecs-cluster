#!/bin/bash
#
# Deploys a Jenkins master docker container to AWS ECR (Elastic Container Repository)
#
# Author: Jason DeBolt (jasondebolt@gmail.com)
#
# USAGE:
#  ./deploy-docker-image.sh

set -e

IMAGE_NAME=`jq -r '.Parameters.ImageName' template-ecs-params.json`
AWS_ACCOUNT_ID=`aws sts get-caller-identity --output text --query Account`
AWS_REGION=`aws configure get region`

docker build -t $IMAGE_NAME .
docker tag $IMAGE_NAME:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_NAME:latest

# Obtain auth with AWS Elastic Container Rep
eval $(aws ecr get-login --no-include-email --region $AWS_REGION)

docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_NAME:latest
