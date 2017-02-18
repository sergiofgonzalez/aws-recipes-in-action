#!/bin/bash

AWS_DEFAULT_PROFILE=hackathon

VPC_ID=$(aws ec2 describe-vpcs --query Vpcs[0].VpcId --output text)
SUBNET_ID=$(aws ec2 describe-subnets --filters Name=vpc-id,Values=$VPC_ID --query Subnets[0].SubnetId --output text)
SHARED_SECRET=$(openssl rand -base64 30)
PASSWORD=$(openssl rand -base64 30)

echo "========================="
echo "VPC_ID        : $VPC_ID"
echo "SUBNET_ID     : $SUBNET_ID"
echo "SHARED_SECRET : $SHARED_SECRET"
echo "PASSWORD      : $PASSWORD"

aws cloudformation create-stack --stack-name vpn \
--template-url https://s3.us-east-2.amazonaws.com/cf-templates-1el7cur6biglt-us-east-2/openswan-vpn-template.yaml \
--parameters ParameterKey=KeyName,ParameterValue=aws-in-action-key-pair \
ParameterKey=VPC,ParameterValue=$VPC_ID \
ParameterKey=Subnet,ParameterValue=$SUBNET_ID \
ParameterKey=IPSecSharedSecret,ParameterValue=$SHARED_SECRET \
ParameterKey=VPNUser,ParameterValue=vpn \
ParameterKey=VPNPassword,ParameterValue=$PASSWORD

echo "Waiting for the vpn stack to be complete..."
aws cloudformation wait stack-create-complete --stack-name vpn

aws cloudformation describe-stacks --stack-name vpn --query Stacks[0].Outputs
