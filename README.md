#### Run a Jenkins cluster on AWS using Elastic Container Service

#### Requirements
* Tested on a Mac only
* $ brew install jq
* AWS CLI and AWS credentials.
* Python
* For simplicity, I left the ECR Repo IAM permissions open.

+<h1>Create a Jenkins cluster in AWS</h1>
+<img height="70" src="https://upload.wikimedia.org/wikipedia/commons/8/88/Ovpntech_logo-s_REVISED.png">
+<br />
+<a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?templateURL=https://s3.amazonaws.com/jasondebolt-cloud-formation/template-jenkins-cluster.json">
+<img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png">
+</a>
