# Identity and Access Management (IAM) Service
> notes on IAM service

## Introduction
The Identity and Access Management (IAM) service provides everything needed for authentication and authorization with the AWS API. Every request goes through IAM to to check whether the request is allowed.

IAM controls who (authentication) can do what (authorization). Authentication with IAM is done with users or roles, whereas authorization is done by policies. Roles are typically intended for services.

Both IAM users and roles are based on policies for authorization.

### Policies
A policy is a JSON document containing one or more statements that either allow or deny specific actions on resources. The wildcard character `*` can be used to create generic statements.

**Example 1:** The following policy allows all EC2 actions across all resources
```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "1",
    "Effect": "Allow",
    "Action": ["ec2:*"],
    "Resource": ["*"]
  }]
}
```

The `"Effect": "Deny"` effect has a higher precedence than `"Effect": "Allow"`. Thus, when you deny an action, you can't allow that action with another statement. 
**Example 2:** Denying specific actions
```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "1",
    "Effect": "Allow",
    "Action": ["ec2:*"],
    "Resource": ["*"]
  }, {
    "Sid": "2",
    "Effect": "Deny",
    "Action": ["ec2:TerminateInstances"],
    "Resource": ["*"]
  }]
}

All resources on AWS are identified by their Amazon Resource Name (ARN). You can find the *ARN* on the console or using the CLI:
```bash
$ aws iam get-user --query "User.Arn"
"arn:aws:iam::555555555555:user/aws-user"              
```

With *ARNs* you can fine tune the specific resources that apply to a given policy. To do that, you need to know the *AccountID* and build the *ARN* for the instance using the syntax:
```javascript
ARN=`arn:aws:ec2:${region}:${account-id}:instance/${instance-id}`
```

**Example 3:** Allow the termination of a specific instance
```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "1",
    "Effect": "Allow",
    "Action": ["ec2:*"],
    "Resource": ["arn:aws:ec2:us-east-1:555555555555:instance/i-0165f31c9a7e90d6e"]
  }]
}
```

There are two types of policies:
+ **Managed Policies** &mdash; Policies that can be reused in your account.
  + **AWS Managed Policies** &mdash; Policies maintained by AWS.
  + **Customer Managed** &mdash; Policies that represent roles in an organizations
* **Inline Policies** &mdash; Policies that are bound to a certain IAM role, user or group.

### Users and Groups
IAM users can authenticate with either a password (AWS console) or an access key (CLI/API).
It's recommended to create groups to managed authorizations &mdash; although a group can't be used to authenticate, it centralizes authorization tasks (for example if you want to prevent admins to terminate instances you only need to change the policy for the group instead of changing the policies of each of the admin users).

### IAM Roles
IAM roles are used to authenticate AWS resources like virtual servers. Each AWS API request from an AWS resource (like an S3 request being submitted from an EC2 server) will authenticate with the roles attached.

For example, you can create a role that allows an EC2 instance to stop itself after a while. From the management console, you can go to the IAM section and create a new role `aws-ia-stop-instance` and attach the following inline policy (that has been tailored down from the `AmazonEC2StartStopPolicyAccess` managed policy:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
         "ec2:DescribeInstances",
         "ec2:StopInstances"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
```

Now you can launch an Amazon Linux AMI instance from the AWS Management Console, select `aws-ia-stop-instace` as the IAM role, and configure the following userData script:
```bash
#!/bin/bash
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
echo "aws --region us-east-2 ec2 stop-instances --instance-ids $INSTANCE_ID" | at now + 5 minutes
```

The instance will be automatically stopped after 5 minutes.

You can also do the same thing using *CloudFormation*. You can find the complete *CloudFormation* stack in `server-with-roles.yaml`. You'll see that the policy features the following interesting sections in the `Resources` section:
+ `SecurityGroup` &mdash; Defines the SecurityGroup for the server
+ `Role` &mdash; Defines the IAM Role for the server. It contains the action `sts:AssumeRole` and a policy that allows the `ec2:StopInstances`. In this policy, the Resource is kept as `Resource: "*"` because we don't know what the InstanceId will be. To improve the security of the policy, we include a condition which will limit the effect of the policy if the instance is tagged with the Stack ID:
```yaml
Condition:
  StringEquals:
    "ec2:ResourceTag/aws:cloudformation:stack-id": !Ref "AWS::StackId"
```
+ `InstanceProfile` &mdash; Needed to attach an inline role to an instance
+ `EC2Instance` &mdash; which features a property `IamInstanceProfile` which references the `InstanceProfile`

Note that in this case, an Ubuntu image is used (instead of a Amazon Linux AMI). In this image, we first need to install the AWS SDK, and only then we can run the command to get the instance ID to be able to schedule stopping the instance:
```yaml
      UserData:
        "Fn::Base64": !Sub |
          #!/bin/bash -xe
          apt-get -y update
          apt-get -y install python-pip
          pip install awscli
          INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
          echo "aws --region us-east-2 ec2 stop-instances --instance-ids $INSTANCE_ID" | at now + ${Lifetime} minutes
```

