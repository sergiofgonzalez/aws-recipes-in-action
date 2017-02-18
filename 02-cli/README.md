# Part 2: The Command Line Interface (CLI)
> interacting with AWS from the command line and shell scripts

## Examples & Recipes

### [1 &mdash; Using AWS Command Line Interface](01-cli-commands/)
Illustrates how to spin up a new instance using a shell script.

### [2 &mdash; Invoking CloudFormation from the CLI](02-cloud-formation-from-cli/)
Illustrates how to invoke the creation of a CloudFormation stack from a CLI script.

### [3 &mdash; Patching an EC2 instance from the CLI](03-updating-software-from-cli/)
Demonstrates how to patch the software of an EC2 instance from the CLI.

### [4 &mdash; Creating IAM Groups and Users](04-hello-iam/)
Illustrates how perform IAM related tasks using the CLI.

## Documentation

### AuthFailure: AWS was not able to validate the provided access credentials 
If you get AuthFailure err message, verify that the system clock is is accurate. If there is a major difference between in the time AWS will reject some of the requests.

In Ubuntu 16.04 time synchronization is handled by `timedatectl` which automatically updates time/date without user intervention. However, if you're using a VM and have (for example) sent the VM to sleep, etc. the time can temporarily be incorrect.

In those cases, a simple reboot should bring the time up-to-date

## Credentials with different profiles
AWS credentials file supports the specification of profiles to handle different credential sets. In order to use an specific profile you have to set the `AWS_DEFAULT_PROFILE`.

For example, to activate the profile `hackathon` you should type:

```bash
export AWS_DEFAULT_PROFILE=hackathon
```

### JMESPath
*JMESPath* is a query language that AWS CLI uses to extract data from a JSON result set. This is useful when you only need to retrieve a specific value (or set of values from the response).

#### Getting all properties from a result set

The following example, returns an array with all the `RegionName` properties:
```bash
$ aws ec2 describe-regions
{
    "Regions": [
        {
            "Endpoint": "ec2.ap-south-1.amazonaws.com",
            "RegionName": "ap-south-1"
        },
        {
            "Endpoint": "ec2.eu-west-2.amazonaws.com",
            "RegionName": "eu-west-2"
        },
...
}
$ aws ec2 describe-regions --query "Regions[*].RegionName"
[
    "ap-south-1",
    "eu-west-2",
...
]
```

#### Getting the first property from a result set

The following example is used to retrieve the first entry from the result:

```bash
$ aws ec2 describe-images --query "Images[0].ImageId"
"aki-d83a61bd"
```