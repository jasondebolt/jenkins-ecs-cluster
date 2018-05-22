#!/bin/bash
set -e

# Generate an AWS Elastic Container Repository (ECR) to host a Jenkins docker container
# Usually there is a 1:1 mapping between ECR repo names and image names.
#
# Author: Jason DeBolt (jasondebolt@gmail.com)
#
# USAGE:
#   ./deploy-docker-repo.sh [create | update]
#
# EXAMPLES:
#   ./deploy-docker-repo.sh create
#   ./deploy-docker-repo.sh update

IMAGE_NAME=`jq -r '.Parameters.ImageName' template-ecs-params.json`

# Check for valid arguments
if [ $# -ne 1 ]
  then
    echo "Incorrect number of arguments supplied. Pass in either 'create' or 'update'."
    exit 1
fi

# Validate the CloudFormation template before template execution.
aws cloudformation validate-template --template-body file://template-docker-repo.json

# Create or update the CloudFormation stack with deploys your docker service to the Dev cluster.
aws cloudformation $1-stack --stack-name $IMAGE_NAME-docker-repo \
    --template-body file://template-docker-repo.json \
    --parameters ParameterKey=RepoName,ParameterValue=$IMAGE_NAME
