# Part 3: The Amazon Web Services API
> interacting with AWS programmatically using AWS SDK

## Examples and Recipes

### [1 &mdash; Listing AMIs using Node.js](01-nodejs-list-amis/)
Illustrates how to use the `aws-sdk` from *Node.js* to list the AMIs.

### [2 &mdash; Listing EC2 Servers using Node.js](02-nodejs-list-servers/)
Illustrates how to use the `aws-sdk` from *Node.js* to list the virtual servers in a given region.

### [3 &mdash; Listing EC2 Servers using Node.js](03-nodejs-server-info/)
Illustrates how to use the `aws-sdk` from *Node.js* to obtain the server information given its *Instance ID*.

## Documentation

### Credentials: Using Multiple Profiles

AWS lets you keep your AWS credentials data in a shared file used by the SDK and the CLI. The Node.js SDK automatically searches for the shared credentials file (`~/.aws/credentials`) and assumes the default profile.

This might not be desirable if you need to select a set of credentials different from the default one. When using the CLI you can use the `AWS_DEFAULT_PROFILE` environment variable, and you can also use the `AWS_PROFILE` when using the `aws-sdk` module.

However, the environment variable solution is not very flexible when using the programmatic approach, as you must set the variable before requiring the `aws-sdk`:

```javascript
/* this will work */
const AWS = require("aws-sdk");
process.env["AWS_PROFILE"]="hackathon";
```

Alternatively, you can configure the credentials to use a specific profile for added flexibility:

```javascript
const credentials = new AWS.SharedIniFileCredentials({profile: config("AWS:PROFILE")});
AWS.config.credentials = credentials;
```

### Additional Information
More information: http://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/loading-node-credentials-shared.html