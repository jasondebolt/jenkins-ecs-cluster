## Run a Jenkins cluster on AWS using Elastic Container Service
You can run the Jenkins cluster either by clicking the big yellow buttons below or by running the deploy shell scripts.


### Deploying using the web interface
1) Click on the VPC button below
2) Name the stack "devops-vpc"
3) Leave the default values, but <b> make sure to call the stack "devops-vpc"</b>.
4) While the VPC stack is creating, create an AWS ACM certificate (https://console.aws.amazon.com/acm)
5) Click "request a public certificate" and enter a domain that you own.
6) Create two entries: "your-domain.com" and "*.your-domain.com".
7) If you do not own a domain, buy a test domain in route53 for $12 by clicking on "Registered Domains" in route53 (http://console.aws.amazon.com/route53)
 
  

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
