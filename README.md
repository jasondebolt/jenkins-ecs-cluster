## Run a Jenkins cluster on AWS using Elastic Container Service
You can run the Jenkins cluster either by clicking the big yellow buttons below or by running the deploy shell scripts.


### Deploying using the web interface
0) Run this command: "aws iam create-service-linked-role --aws-service-name ecs.amazonaws.com"
1) Click on the VPC button below and click the blue "next" button.
2) The name of the stack should be <b> devops-vpc </b>.
3) Leave the default values, but <b> make sure to call the stack "devops-vpc"</b>.
4) While the VPC stack is creating, create an [AWS ACM SSL certificate](https://console.aws.amazon.com/acm)
5) Click "request a public certificate" and enter a domain that you own.
6) Create two entries: "your-domain.com" and "*.your-domain.com".
7) If you do not own a domain, buy a test domain in route53 for $12 by clicking on "Registered Domains" in the [Route53 console](http://console.aws.amazon.com/route53). I have only tested ACM with ".com" domains. It usually about 10-15 minutes to process and receive the domain in route53. 
8) Within the [AWS ACM console](https://console.aws.amazon.com/acm), click on the little arrow near to your domain to view more information about it. Copy the ARN of your ACM certificate somewhere for later use.
9) While you are waiting for your verification email for your ACM, create a public hosted zone for your domain in the [Route53 console](http://console.aws.amazon.com/route53). In the route53 console, click on the radio button near your domain name and to view the hosted zone ID on the right. Copy this ID somewhere for later use.
10) Also, create an SSH key pair in the AWS EC2 console so you can SSH into the Jenkins server if necessary. Open the [EC2 console](https://console.aws.amazon.com/ec2), click on "KeyPairs" on the lower left side of the page, and then click "Create Key Pair". Take note of the name of the key as you will need to enter that later.
11) Verify that the VPC CloudFormation stack [has completed](http://console.aws.amazon.com/cloudformation). If so, click on the big yellow button below the "Launch the Jenkins Cluster" section.
12) Give the stack a name, like "jenkins-cluster"
13) Enter your domain in the "Domain" field.
14) Leave the ELBSubnets option as "Public" if you want to access your Jenkins cluster over the internet. If you select "Private", the Jenkins ELB will be in a private subnet, inaccessible over the internet.
15) Enter your Hosted Zone ID that you copied from the public hosted zone for your domain in Route53.
16) In the "IpWhitelist" section, enter your IP address with "/32" appended so you can access the elastic load balancer over port 443 (i.e 12.34.56.89/32) . The servers behind the ELB are not accessible over the internet by default and are only accessible to the ELB. 
17) Scroll down to the "KeyPair" field. Select the key pair that you generated earlier. The security groups in this stack do not allow SSH access by default, but you can only add SSH key pairs upon instance creation.
18) Scroll down to the bottom to find the "SSLCertificateARN" field. Enter the ARN ofthe AWS ACM certificate that you created earlier. 
19) Scroll down to the bottom and make sure that the "WebSubnets" field is marked as private. This ensures that all instances are not accessible over the internet. 
20) Leave all other values as default. Click next, the click next again. 
21) Check the checkbox at the bottom and click "Create" to create the CloudFormation stack. The stack will take about 10 minutes to create.

### After the Jenkins Cluster stack has been deployed
* Once the status of the Jenkins Cluster stack says "COMPLETED", click on the ["Outputs"](https://console.aws.amazon.com/cloudformation) tab to find the URL of the Jenkins Application Load Balancer.
* Click on the URL to view the Jenkins master node.
 
  

<h3> Launch the VPC </h3>
</a>
<a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?templateURL=https://s3.amazonaws.com/jasondebolt-public/template-vpc.json">
<img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png">
</a>

<h3> Launch the Jenkins Cluster </h3>
</a>
<a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?templateURL=https://s3.amazonaws.com/jasondebolt-public/template-jenkins-cluster.json">
<img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png">
</a>

### Security Notes
* All EC2 instances in this stack are not accessible over the internet by default. The ELB, however, is accessible over the internet by default.
* The Jenkins servers and ELB are accessible to 10.0.0.0/16 by default in case you want to set up a peering connection through that CIDR range for VPN support if you decide to place your ELB in an private subnet.

### Disclaimers
* This solution is not perfect. All of the code in this repo was created in about 2 days. 
* Please make sure to review/change this stack as needed to make it as secure as possible before attempting to use in production.

### Deploying with the shell scripts
* Tested on a Mac only
* $ brew install jq
* AWS CLI and AWS credentials.
* Python
* For simplicity, I left the ECR Repo IAM permissions open.
