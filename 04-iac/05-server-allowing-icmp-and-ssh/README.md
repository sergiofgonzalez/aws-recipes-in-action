# IaC &raquo; Server allowing ICMP and SSH traffic
> CloudFormation template defining an EC2 server that responds to pings (ICMP) and allows to SSH into it

## Description
Template that defines an EC2 server with a security group that allows inbound ICMP messages (that is, will respond to `ping`) and will also allows to SSH into it.
