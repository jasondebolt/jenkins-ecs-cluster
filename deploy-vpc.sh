#!/bin/bash
set -e

# Creates or updates a DevOps VPC.
#
# Author: Jason DeBolt (jasondebolt@gmail.com)
#
# USAGE
#   ./deploy-vpc.sh [create | update]


# Check for valid arguments
if [ $# -ne 1 ]
  then
    echo "Incorrect number of arguments supplied. Pass in either 'create' or 'update'."
    exit 1
fi

ENVIRONMENT=`jq -r '.Parameters.Environment' template-ecs-params.json`

python parameters_generator.py template-vpc-params.json > temp.json

# Validate the CloudFormation template before template execution.
aws cloudformation validate-template --template-body file://template-vpc.json

# Create or update the demo VPC.
aws cloudformation $1-stack \
    --stack-name devops-vpc \
    --template-body file://template-vpc.json \
    --parameters file://temp.json

rm temp.json
