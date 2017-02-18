# The CLI &raquo; Patching an Instance from the CLI
> updating a running EC2 instance with the latest security updates without opening an interactive session.


## Description
Illustrates how to create a simple script that uses AWS CLI to retrieve the public names of the running machines and performs the installation of security updates.

In the example, an Ubuntu instance is patched, but the same approach can be used with an Amazon Linux AMI using `sudo yum -y --security update`.