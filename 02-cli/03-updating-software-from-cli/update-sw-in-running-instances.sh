#!/bin/bash

AWS_DEFAULT_PROFILE=hackathon

PUBLIC_NAMES=$(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query="Reservations[].Instances[].PublicDnsName" --output text)

echo "========================="
echo "PUBLIC_NAMES  : $PUBLIC_NAMES"

# logs for unattended-upgrade can be found in /var/log/unattended-upgrades/unattended-upgrades.log
for PUBLIC_NAME in $PUBLIC_NAMES
do
  ssh -i key-pair-name.pem -t -o StrictHostKeyChecking=no ubuntu@$PUBLIC_NAME "sudo apt-get update && sudo unattended-upgrade"
done

