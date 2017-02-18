# The CLI &raquo; Invoking CloudFormation from the CLI
> invoking cloudformation from cli to automate stack creation

## Description
Illustrates how to invoke the `aws cloudformation` commands from the CLI to be able to create a *CloudFormation* stack. The template has been created using *YAML syntax* and includes user data.

**Note**
The userData includes the retrieval of a remote script using curl that is intended for an Amazon AMI and therefore will not work on ubuntu. However, you can check that the userData has been correctly composed by accessing http://169.254.169.254/latest/user-data from the created instance:

```bash
#!/bin/bash -xe
export IPSEC_PSK=zJ5bgLnzr/FGzpItgP2B5fmxeS04SCdEYnAKmQok
export VPN_USER=vpn
export VPN_PASSWORD=iPy+XnJ18V4CEEjekrDpgam2nLrcvGT7IsdkCpIB
export STACK_NAME=vpn
export REGION=us-east-2
curl -s https://raw.githubusercontent.com/AWSinAction/code/master/chapter5/vpn-setup.sh | bash -ex
```

