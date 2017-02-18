#!/bin/bash

AWS_DEFAULT_PROFILE=hackathon

# It's not that easy to get the correct ami-id without the console
# as descriptions, are not consistent in AWS AMI registration


AMI_ID=ami-fcc19b99
KEY_PAIR_NAME=aws-in-action-key-pair

VPC_ID=$(aws ec2 describe-vpcs --filter "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text)
SUBNET_ID=$(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID" --query "Subnets[0].SubnetId" --output text)
SEC_GRP_ID=$(aws ec2 create-security-group --group-name temp_security_group --description "Temporary Security group created from the CLI" --vpc-id vpc-cb689da2 --output text)

aws ec2 authorize-security-group-ingress --group-id $SEC_GRP_ID --protocol tcp --port 22 --cidr 0.0.0.0/0

INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --key-name $KEY_PAIR_NAME --instance-type t2.micro --security-group-ids $SEC_GRP_ID --subnet-id $SUBNET_ID --query "Instances[0].InstanceId" --output text)


echo "=================================================="
echo "AWS_DEFAULT_PROFILE: $AWS_DEFAULT_PROFILE"
echo "AMI_ID             : $AMI_ID"
echo "KEY_PAIR_NAME      : $KEY_PAIR_NAME"
echo "VPC_ID             : $VPC_ID"
echo "SUBNET_ID          : $SUBNET_ID"
echo "SEC_GRP_ID         : $SEC_GRP_ID"
echo "INSTANCE_ID        : $INSTANCE_ID"     

echo "waiting for $INSTANCE_ID to be ready..."
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

PUBLIC_NAME=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].PublicDnsName" --output text)

echo "$INSTANCE_ID is accepting SSH connections under $PUBLIC_NAME"
echo "ssh -i ${KEY_PAIR_NAME}.pem ubuntu@$PUBLIC_NAME"

read -p "Press [Enter] to key to terminate $INSTANCE_ID..."
aws ec2 terminate-instances --instance-ids $INSTANCE_ID

echo "Terminating $INSTANCE_ID..."

aws ec2 wait instance-terminated --instance-ids $INSTANCE_ID
aws ec2 delete-security-group --group-id $SEC_GRP_ID

echo "Finished"