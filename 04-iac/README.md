# Part 4: Using AWS CloudFormation templates to deploy IaC
> managing and provisioning computing infrastructure as code (IaC) on AWS using CloudFormation

## Examples and Recipes

### [1 &mdash; Provisioning an EC2 Server with CloudFormation](01-creating-server-cloud-formation/)
Illustrates how to create a *YAML CloudFormation template* that describes the infrastructure as code (IaC).

### [2 &mdash; Provisioning a VPN infrastructure using CloudFormation](02-vpn-template/)
Illustrates how to create a *YAML CloudFormation template* describing the infrastructure needed for a VPN.

### [3 &mdash; Provisioning a Server Featuring an Instance Role](03-hello-iam/)
Illustrates how to create a *YAML CloudFormation template* that defines a server with an IAM Role that allows the instance to stop itself after a configured number of minutes.

### [4 &mdash; Provisioning a Server that allows Inbound ICMP traffic (ping)](04-server-allowing-icmp/)
Illustrates how to create a *YAML CloudFormation template* that defines a server with a security group that allows ICMP traffic.

### [5 &mdash; Provisioning a Server that allows Inbound ICMP and SSH traffic](05-server-allowing-icmp-and-ssh/)
Illustrates how to create a *YAML CloudFormation template* that defines a server with a security group that allows ICMP and SSH traffic.

### [6 &mdash; Provisioning a Server that allows Inbound ICMP and SSH traffic for a specific address](06-server-allowing-icmp-and-ssh-specific-ip/)
Illustrates how to create a *YAML CloudFormation template* that defines a server with a security group that allows ICMP and SSH traffic but only from a specific IPv4 address.

### [7 &mdash; Provisioning an application with a Bastion Host](07-bastion-host/)
Illustrates how to create a *YAML CloudFormation template* defining an EC2 server that acts as a Bastion Host for an application server.

### [8 &mdash; Provisioning a nondefault VPC](08-hello-vpc/)
Illustrates how to create a *YAML CloudFormation template* that defines all resources associated to a nondefault VPC.

## Documentation

### Additional Information
Snippets: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/CHAP_TemplateQuickRef.html