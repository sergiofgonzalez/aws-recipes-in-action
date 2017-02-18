# The CLI &raquo; Using AWS Command Line Interface
> misc notes about CLI usage

## Description
The shell script `create-short-live-temp-ubuntu-vm.sh` demonstrates how to spin up an EC2 virtual server using a shell script.
The script requires two parameters:
+ `AMI_ID` &mdash; the image id to use for the EC2 instance
+ `KEY_PAIR_NAME` &mdash; the key pair name to be bound to the machine

The script will read the default *VPC* and *Subnet* and will create a new *security group* that will allow to SSH into the new machine. Then, the new server will be spun up and the server details will be displayed on the console. 
Once the user types *[Enter]* the instace will be terminated and the *security group* will be deleted.
