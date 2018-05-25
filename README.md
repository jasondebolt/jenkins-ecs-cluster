## Run a Jenkins cluster on AWS using Elastic Container Service
You can run the Jenkins cluster either by clicking the big yellow buttons below or by running the deploy shell scripts.


### Deploying using the web interface
1) Click on the VPC button below
2) Leave the default values

<h3> Launch the VPC </h3>
</a>
<a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?templateURL=https://s3.amazonaws.com/jasondebolt-public/template-vpc.json">
<img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png">
</a>

<h3> Launch the Jenkins cluster </h3>
</a>
<a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?templateURL=https://s3.amazonaws.com/jasondebolt-public/template-jenkins-cluster.json">
<img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png">
</a>

### Deploying with the shell scripts
* Tested on a Mac only
* $ brew install jq
* AWS CLI and AWS credentials.
* Python
* For simplicity, I left the ECR Repo IAM permissions open.
