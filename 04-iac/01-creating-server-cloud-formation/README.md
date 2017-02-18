# IaC &raquo; Creating an EC2 Server
> using CloudFormation template to provision a virtual server and a security group that allows to SSH into it

## Description
Illustrates how to provision a server using a *CloudFormation* template.
In the template, we allow the user to specify the *key pair*, *VPC* and *Subnet*, and *Server Type*.
Then, a Security Group for the server is defined allowing to SSH into it along with the EC2 instance.