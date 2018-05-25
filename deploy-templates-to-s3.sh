#!/bin/bash
set -e

aws s3 cp template-jenkins-cluster.json s3://jasondebolt-public
aws s3 cp template-vpc.json s3://jasondebolt-public
