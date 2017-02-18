# IaC &raquo; VPN Infrastructure
> invoking cloudformation from cli to automate stack creation


## Description
Illustrates how to use a *CloudFormation* stack to describe the infrastructure needed for a VPN.

The template creates an instance with *User Data* and a *Security Group* with multiple rules.

**Note**
The userData includes the retrieval of a remote script using curl that is intended for AmazonAMI and therefore will not work on ubuntu. However, you can check that the userData has been correctly composed by accessing http://169.254.169.254/latest/user-data from the created instance:
```bash
#!/bin/bash -xe
export IPSEC_PSK=zJ5bgLnzr/FGzpItgP2B5fmxeS04SCdEYnAKmQok
export VPN_USER=vpn
export VPN_PASSWORD=iPy+XnJ18V4CEEjekrDpgam2nLrcvGT7IsdkCpIB
export STACK_NAME=vpn
export REGION=us-east-2
curl -s https://raw.githubusercontent.com/AWSinAction/code/master/chapter5/vpn-setup.sh | bash -ex
```

