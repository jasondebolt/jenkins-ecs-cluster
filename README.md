#### Run a Jenkins cluster on AWS using Elastic Container Service

#### Requirements
* Tested on a Mac only
* $ brew install jq
* AWS CLI and AWS credentials.
* Python
* For simplicity, I left the ECR Repo IAM permissions open.

<h1>Launch the VPC</h1>
<a href="https://jasondebolt.github.io/template-vpc.json"
<img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png">
</a>

<h1>Create a Jenkins cluster in AWS</h1>
<a href="https://jasondebolt.github.io/template-jenkins-cluster.json"
<img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png">
</a>
