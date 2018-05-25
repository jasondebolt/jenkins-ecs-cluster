#### Run a Jenkins cluster on AWS using Elastic Container Service
You can run the Jenkins cluster either by clicking the big yellow buttons below or by running the deploy shell scripts.

<h1>Launch the VPC</h1>

</a>
<a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?templateURL=https://s3.amazonaws.com/jasondebolt-public/template-vpc.json">
<img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png">
</a>

<h1>Create a Jenkins cluster in AWS</h1>
</a>
<a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?templateURL=https://s3.amazonaws.com/jasondebolt-public/template-jenkins-cluster.json">
<img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png">
</a>

#### Requirements for deploying from the command line
* Tested on a Mac only
* $ brew install jq
* AWS CLI and AWS credentials.
* Python
* For simplicity, I left the ECR Repo IAM permissions open.
