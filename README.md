## Run a Jenkins cluster on AWS using Elastic Container Service
You can run the Jenkins cluster either by clicking the big yellow buttons below or by running the deploy shell scripts.


### Deploying using the web interface
1) Click on the VPC button below
2) Name the stack "devops-vpc"
3) Leave the default values, but <b> make sure to call the stack "devops-vpc"</b>.
4) While the VPC stack is creating, create an [AWS ACM SSL certificate](https://console.aws.amazon.com/acm)
5) Click "request a public certificate" and enter a domain that you own.
6) Create two entries: "your-domain.com" and "*.your-domain.com".
7) If you do not own a domain, buy a test domain in route53 for $12 by clicking on "Registered Domains" in the [Route53 console](http://console.aws.amazon.com/route53). Takes about 10-15 minutes to register the domain.
8) Within the [AWS ACM console](https://console.aws.amazon.com/acm), click on the little arrow near to your domain to view more information about it. Copy the ARN of your ACM certificate somewhere for later use.
9) While you are waiting for your verification email for your ACM, create a public hosted zone for your domain in the [Route53 console](http://console.aws.amazon.com/route53). In the route53 console, click on the radio button near your domain name and to view the hosted zone ID on the right. Copy this ID somewhere for later use.
10) Also, create an SSH key pair in the AWS EC2 console so you can SSH into the Jenkins server if necessary. Open the [EC2 console](https://console.aws.amazon.com/ec2), click on "KeyPairs" on the lower left side of the page, and then click "Create Key Pair". Take note of the name of the key as you will need to enter that later.

 
  

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
