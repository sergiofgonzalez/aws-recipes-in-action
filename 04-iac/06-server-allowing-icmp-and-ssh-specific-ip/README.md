# IaC &raquo; Server allowing ICMP and SSH traffic for a specific address
> CloudFormation template defining an EC2 server that responds to pings (ICMP) and allows to SSH into it but only for a specific IP address.

## Description
Template that defines an EC2 server with a security group that allows inbound ICMP messages (that is, will respond to `ping`) and will also allows to SSH into it but only for a specific IPv4 address.

You can obtain your public IPv4 address using the endpoint: https://api.ipify.org/
