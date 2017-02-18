# Getting Started &raquo; Creating the Key Pair
> using `ssh-keygen` to generate a key pair for AWS

## Description
To access a virtual server in AWS you need a key pair consisting of a private key and public key. Amazon EC2 uses public-key cryptography to encrypt and decrypt login information.

To log into your instance, you must create a key pair, specify the name of the key pair when you launch the instance, and provide the private key when you connect to the instance.

To create a 4096 bit, RSA, key pair using `ssh-keygen` type:
```bash
$ ssh-keygen -t rsa -b 4096 -C "aws-in-action-key-pair"
$ mv aws-in-action-key-pair aws-in-action-key-pair.pem
```

### Connecting to a Virtual Server configured with that Key Pairs
You can connect to an EC2 virtual server (assuming its IPv4 address is 52.14.87.11) configured with the public key of the recently generated key pair by typing:
```bash
$ ssh -i aws-in-action-key-pair.pem ubuntu@52.14.87.11
```
