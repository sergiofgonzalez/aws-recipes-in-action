# Part 2: The Command Line Interface (CLI)
> interacting with AWS from your terminal using the *AWS CLI* and shell scripts

## Examples & Recipes

### [1 &mdash; Using AWS Command Line Interface](01-cli-commands/)
Illustrates how to interact with AWS using the CLI.

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
AWS credentials file supports the specification of profiles to handle different credential sets. In order to use an specific profile without having to type it constantly in all of your commands, you have to set the `AWS_DEFAULT_PROFILE` environment variable.

For example, to activate a profile named `hackathon` you should type:

```bash
export AWS_DEFAULT_PROFILE=hackathon
```

### JMESPath
The AWS CLI support *JMESPath* query language to extract data from a JSON responses. This is useful when you only need to retrieve a specific set of attributes as seen in the examples below.

| NOTE: |
| :--- |
| The following examples assumes you're already using AWS CLI v2 |

#### Getting all properties from a result set

The following command, lists all instance types and their characteristics:
```bash
$ aws2 ec2 describe-instance-types
{
    "InstanceTypes": [
        {
            "InstanceType": "c5n.4xlarge",
            "CurrentGeneration": true,
            "FreeTierEligible": false,
            "SupportedUsageClasses": [
                "on-demand",
                "spot"
            ],
            "SupportedRootDeviceTypes": [
                "ebs"
            ],
            "BareMetal": false,
            "Hypervisor": "nitro",
            "ProcessorInfo": {
                "SupportedArchitectures": [
                    "x86_64"
                ],
                "SustainedClockSpeedInGhz": 3.4
            },
            "VCpuInfo": {
                "DefaultVCpus": 16,
                "DefaultCores": 8,
                "DefaultThreadsPerCore": 2,
                "ValidCores": [
                    2,
                    4,
                    6,
                    8
                ],
                "ValidThreadsPerCore": [
                    1,
                    2
                ]
            },
            "MemoryInfo": {
                "SizeInMiB": 43008
            },
            "InstanceStorageSupported": false,
            "EbsInfo": {
                "EbsOptimizedSupport": "default",
                "EncryptionSupport": "supported"
            },
            "NetworkInfo": {
                "NetworkPerformance": "Up to 25 Gigabit",
                "MaximumNetworkInterfaces": 8,
                "Ipv4AddressesPerInterface": 30,
                "Ipv6AddressesPerInterface": 30,
                "Ipv6Supported": true,
                "EnaSupport": "required"
            },
            "PlacementGroupInfo": {
                "SupportedStrategies": [
                    "cluster",
                    "partition",
                    "spread"
                ]
            },
            "HibernationSupported": false,
            "BurstablePerformanceSupported": false,
            "DedicatedHostsSupported": true,
            "AutoRecoverySupported": true
        },
        {
            "InstanceType": "inf1.xlarge",
            "CurrentGeneration": true,
            "FreeTierEligible": false,
            "SupportedUsageClasses": [
                "on-demand",
                "spot"
            ],
            "SupportedRootDeviceTypes": [
                "ebs"
            ],
            "BareMetal": false,
            "Hypervisor": "nitro",
            "ProcessorInfo": {
                "SupportedArchitectures": [
                    "x86_64"
                ],
[...]
```

#### Getting a Specific Item From the Response
As seen above, the command returns an array of *InstanceTypes*. To extract the third instance only, you would use:

```bash
$ aws2 ec2 describe-instance-types --query "InstanceTypes[3]"
{
    "InstanceType": "h1.8xlarge",
    "CurrentGeneration": true,
    "FreeTierEligible": false,
    "SupportedUsageClasses": [
        "on-demand",
…
```

#### Getting a Specific Property From a Specific Item
To extract just the `InstanceType` from the *5th* element of the response:


```bash
$ aws2 ec2 describe-instance-types --query "InstanceTypes[5].InstanceType"
"m5ad.large"
```

#### Getting a Specific Property From the Whole Response Set
To extract just the `InstanceType` from the whole response, you'd do:


```bash
$ aws2 ec2 describe-instance-types --query "InstanceTypes[*].InstanceType"
[
    "c5n.2xlarge",
    "g2.2xlarge",
    "c4.large",
    "r5a.16xlarge",
    "r5a.xlarge",
    [...]
]
```

#### Changing the Output Format of the Response
To obtain the output in text instead of JSON you'd do:


```bash
$ aws2 ec2 describe-instance-types --query "InstanceTypes[*].InstanceType" --output text
c1.medium       m5dn.12xlarge   r3.8xlarge      c4.large        d2.2xlarge      c1.xlarge       r5n.4xlarge     t3.2xlarge      m5d.large       a1.xlarge       i2.2xlarge      t2.2xlarge      z1d.xlarge      inf1.xlarge     c5d.12xlarge    m2.4xlarge      m5dn.xlarge     c5n.9xlarge     g3.8xlarge      m5.xlarge       c4.4xlarge      r5d.4xlarge     m5ad.12xlarge   t3.large        r5a.large       c5n.large       m5.24xlarge     t3a.small       x1e.8xlarge     h1.8xlarge

```
