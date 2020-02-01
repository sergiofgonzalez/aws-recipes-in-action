#!/bin/bash -e

## The script assumes that AWS CLI v2 has been installed and added to the PATH

KEY_NAME=mykey
IMAGE_ID=ami-062f7200baf2fa504

# This just validates that image-id ami-062f7200baf2fa504 is still valid
AMI_ID="$(aws2 ec2 describe-images \
--filters "Name=image-id,Values=ami-062f7200baf2fa504" \
--query "Images[0].ImageId" \
--output text)"
echo "AMI_ID: ${AMI_ID}"

VPC_ID="$(aws2 ec2 describe-vpcs \
--filter "Name=isDefault,Values=true" \
--query "Vpcs[0].VpcId" \
--output text)"
echo "VPC_ID: ${VPC_ID}"

SUBNET_ID="$(aws2 ec2 describe-subnets \
--filters "Name=vpc-id,Values=${VPC_ID}" \
--query "Subnets[0].SubnetId" \
--output text)"
echo "SUBNET_ID: ${SUBNET_ID}"

SECURITY_GROUP_ID="$(aws2 ec2 create-security-group \
--group-name my-security-group \
--description "My Security Group \
--vpc-id ${VPC_ID}" \
--output text)"
echo "SECURITY_GROUP_ID: ${SECURITY_GROUP_ID}"

aws2 ec2 authorize-security-group-ingress \
--group-id ${SECURITY_GROUP_ID} \
--protocol tcp \
--port 22 \
--cidr 0.0.0.0/0
echo "Security Group ingress rules registered"

INSTANCE_ID="$(aws2 ec2 run-instances \
--image-id ${AMI_ID} \
--key-name ${KEY_NAME} \
--instance-type t2.micro \
--security-group-ids "${SECURITY_GROUP_ID}" \
--subnet-id "${SUBNET_ID}" \
--query "Instances[0].InstanceId" \
--output text)"

echo "waiting for EC2 machine with id ${INSTANCE_ID} to be ready..."
aws2 ec2 wait instance-running --instance-ids "${INSTANCE_ID}"

PUBLIC_DNS_NAME="$(aws2 ec2 describe-instances \
--instance-id "${INSTANCE_ID}" \
--query "Reservations[0].Instances[0].PublicDnsName" \
--output text)"

echo "The EC2 machine ${INSTANCE_ID} is accepting connections on ${PUBLIC_DNS_NAME}"
echo "Type:"
echo "ssh -i ${KEY_NAME}.pem ec2-user@${PUBLIC_DNS_NAME}"

read -r -p "Press [ENTER] key to terminate ${INSTANCE_ID}"

aws2 ec2 terminate-instances --instance-ids "${INSTANCE_ID}" --no-paginate
echo "waiting for termination of EC2 machine with id ${INSTANCE_ID}..."
aws2 ec2 wait instance-terminated --instance-ids "${INSTANCE_ID}"  

aws2 ec2 delete-security-group --group-id "${SECURITY_GROUP_ID}"
echo "Cleaning up finished successfully"
