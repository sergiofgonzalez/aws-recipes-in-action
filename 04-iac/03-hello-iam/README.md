# IaC &raquo; Defining an EC2 server with roles
> using CloudFormation to create a server with an inline role that stops itself after a configured number of minutes

## Description
The template defines a security group, an IAM role with a policy that allows the holder to stop itself, and an EC2 server with an *Instance Profile*.
The EC2 server is given a user data that installs the AWS CLI and schedules the stopping of the server at the specified time.

To do that, the instance needs to know its own `instance-id` and to do that it uses the `http://169.254.169.254/latest/meta-data/instance-id` endpoint:

```bash
#!/bin/bash
apt-get -y update
apt-get -y install python-pip
pip install awscli
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
echo "aws --region us-east-2 ec2 stop-instances --instance-ids $INSTANCE_ID" | at now + ${Lifetime} minutes
```